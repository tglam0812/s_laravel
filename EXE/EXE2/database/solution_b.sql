-- 1. Liệt kê các hóa đơn của khách hàng
SELECT users.user_id, users.user_name, orders.order_id
FROM users
JOIN orders ON users.user_id = orders.user_id;

-- 2. Liệt kê số lượng các hóa đơn của khách hàng
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders
FROM users
LEFT JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT orders.order_id, COUNT(order_details.product_id) AS total_products
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng (gom nhóm theo đơn hàng)
SELECT users.user_id, users.user_name, orders.order_id, GROUP_CONCAT(products.product_name) AS purchased_products
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.user_id, users.user_name, orders.order_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders
FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name
ORDER BY total_orders DESC
LIMIT 7;

-- 6. Liệt kê 7 người dùng mua sản phẩm có tên 'Samsung' hoặc 'Apple'
SELECT users.user_id, users.user_name, orders.order_id, products.product_name
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price
FROM users
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.user_id, users.user_name, orders.order_id;

-- 8. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất
SELECT u.user_id, u.user_name, o.order_id, MAX(total_price) AS max_price
FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) AS o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name;

-- 9. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất
SELECT u.user_id, u.user_name, o.order_id, MIN(total_price) AS min_price
FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) AS o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name;

-- 10. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm nhiều nhất
SELECT u.user_id, u.user_name, o.order_id, MAX(total_products) AS max_products
FROM (
    SELECT users.user_id, users.user_name, orders.order_id, COUNT(order_details.product_id) AS total_products
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY users.user_id, users.user_name, orders.order_id
) AS o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.user_name;
