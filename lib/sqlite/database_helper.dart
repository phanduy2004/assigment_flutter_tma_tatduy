import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../core/models/cart_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  final uuid = Uuid();

  DatabaseHelper._init();

  /// Băm mật khẩu sử dụng SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    print("Database path: $path"); // Log đường dẫn để debug iOS/Android

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        email TEXT UNIQUE,
        fullName TEXT
      )
    ''');

    /*await db.insert('users', {
      'id': 'u1',
      'username': 'testuser',
      'password': _hashPassword('password123'), // Băm mật khẩu mẫu
      'email': 'testuser@example.com',
      'fullName': 'Người Dùng Test',
    });*/

    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id TEXT PRIMARY KEY,
        productId TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
      )
    ''');
  }

  /*await db.insert('products', {
      'id': 'p1',
      'name': 'Cà Phê Sữa',
      'price': 35000.0,
      'imagePath': 'assets/images/drink.jpg',
    });
    await db.insert('products', {
      'id': 'p2',
      'name': 'Trà Đào',
      'price': 40000.0,
      'imagePath': 'assets/images/drink.jpg',
    });
    await db.insert('products', {
      'id': 'p3',
      'name': 'Caramel Macchiato',
      'price': 55000.0,
      'imagePath': 'assets/images/drink.jpg',
    });
    await db.insert('products', {
      'id': 'p4',
      'name': 'Trà Xanh',
      'price': 45000.0,
      'imagePath': 'assets/images/drink.jpg',
    });
    await db.insert('products', {
      'id': 'p5',
      'name': 'Cà Phê Đen',
      'price': 30000.0,
      'imagePath': 'assets/images/drink.jpg',
    });

    await db.insert('cart', {
      'id': 'c1',
      'productId': 'p1',
      'quantity': 2,
    });
    await db.insert('cart', {
      'id': 'c2',
      'productId': 'p2',
      'quantity': 1,
    });
  }*/

  /// Đăng nhập người dùng với [username] và [password].
  /// Trả về thông tin người dùng nếu thành công.
  /// Ném ngoại lệ nếu đăng nhập thất bại.
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        throw Exception('Username and password cannot be empty');
      }

      final db = await database;
      final result = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username.trim()],
      );

      if (result.isEmpty) {
        throw Exception('User not found');
      }

      final user = result.first;
      final storedPassword = user['password'] as String;
      final hashedInputPassword = _hashPassword(password.trim());

      if (storedPassword != hashedInputPassword) {
        throw Exception('Incorrect password');
      }

      return {
        'id': user['id'],
        'username': user['username'],
        'email': user['email'] ?? '',
        'fullName': user['fullName'] ?? '',
      };
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    String? fullName,
  }) async {
    try {
      // Kiểm tra đầu vào
      if (username.isEmpty || password.isEmpty || email.isEmpty) {
        throw Exception('Username, password, and email cannot be empty');
      }
      if (confirmPassword != password) {
        throw Exception('Password does not match.');
      }
      final db = await database;

      // Kiểm tra trùng lặp username
      final existingUser = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username.trim()],
      );
      if (existingUser.isNotEmpty) {
        throw Exception('Username already exists');
      }

      // Kiểm tra trùng lặp email
      final existingEmail = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email.trim()],
      );
      if (existingEmail.isNotEmpty) {
        throw Exception('Email already exists');
      }

      // Lưu người dùng mới
      final id = uuid.v4();
      final hashedPassword = _hashPassword(password.trim());
      await db.insert(
        'users',
        {
          'id': id,
          'username': username.trim(),
          'password': hashedPassword,
          'email': email.trim(),
          'fullName': fullName?.trim() ?? '',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Trả về thông tin người dùng vừa đăng ký
      return {
        'id': id,
        'username': username,
        'email': email,
        'fullName': fullName ?? '',
      };
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  /// Lưu thông tin người dùng vào cơ sở dữ liệu.
  /// [id] là ID tùy chọn, nếu không cung cấp sẽ tự động tạo UUID.
  /// [username] và [password] là bắt buộc, [email] và [fullName] là tùy chọn.
  Future<void> saveUser({
    String? id,
    required String username,
    required String password,
    String? email,
    String? fullName,
  }) async {
    try {
      if (username.isEmpty) throw Exception('Username cannot be empty');
      if (password.isEmpty) throw Exception('Password cannot be empty');

      final db = await database;
      await db.insert(
        'users',
        {
          'id': id ?? uuid.v4(),
          'username': username.trim(),
          'password': _hashPassword(password.trim()),
          'email': email?.trim(),
          'fullName': fullName?.trim(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  /// Lấy thông tin người dùng dựa trên [username].
  Future<Map<String, dynamic>?> getUser(String username) async {
    try {
      if (username.isEmpty) throw Exception('Username cannot be empty');

      final db = await database;
      final result = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username.trim()],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  /// Cập nhật thông tin hồ sơ người dùng.
  Future<void> updateUserProfile({
    required String username,
    String? email,
    String? fullName,
  }) async {
    try {
      if (username.isEmpty) throw Exception('Username cannot be empty');

      final db = await database;
      await db.update(
        'users',
        {
          'email': email?.trim(),
          'fullName': fullName?.trim(),
        },
        where: 'username = ?',
        whereArgs: [username.trim()],
      );
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Lưu thông tin sản phẩm vào cơ sở dữ liệu.
  Future<void> saveProduct({
    String? id,
    required String name,
    required double price,
    required String imagePath,
  }) async {
    try {
      if (name.isEmpty) throw Exception('Product name cannot be empty');
      if (price <= 0) throw Exception('Price must be greater than 0');
      if (imagePath.isEmpty) throw Exception('Image path cannot be empty');

      final db = await database;
      await db.insert(
        'products',
        {
          'id': id ?? uuid.v4(),
          'name': name.trim(),
          'price': price,
          'imagePath': imagePath.trim(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to save product: $e');
    }
  }

  /// Lấy danh sách tất cả sản phẩm.
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final db = await database;
      return await db.query('products');
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  /// Thêm sản phẩm vào giỏ hàng.
  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      if (productId.isEmpty) throw Exception('Product ID cannot be empty');
      if (quantity <= 0) throw Exception('Quantity must be greater than 0');

      final db = await database;
      final existing = await db.query(
        'cart',
        where: 'productId = ?',
        whereArgs: [productId],
      );

      if (existing.isNotEmpty) {
        await db.update(
          'cart',
          {
            'quantity': (existing.first['quantity'] as int) + quantity,
          },
          where: 'productId = ?',
          whereArgs: [productId],
        );
      } else {
        await db.insert(
          'cart',
          {
            'id': uuid.v4(),
            'productId': productId,
            'quantity': quantity,
          },
        );
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  /// Lấy danh sách các mục trong giỏ hàng.
  Future<List<CartItem>> getCartItems() async {
    try {
      final db = await database;
      final result = await db.rawQuery('''
        SELECT cart.id, cart.productId, cart.quantity, 
               products.name, products.price, products.imagePath
        FROM cart
        JOIN products ON cart.productId = products.id
      ''');

      return result.map((map) => CartItem.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  /// Xóa sản phẩm khỏi giỏ hàng.
  Future<void> removeFromCart(String productId) async {
    try {
      if (productId.isEmpty) throw Exception('Product ID cannot be empty');

      final db = await database;
      await db.delete(
        'cart',
        where: 'productId = ?',
        whereArgs: [productId],
      );
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  /// Đóng cơ sở dữ liệu.
  Future<void> close() async {
    try {
      final db = await database;
      _database = null;
      await db.close();
    } catch (e) {
      throw Exception('Failed to close database: $e');
    }
  }
}
