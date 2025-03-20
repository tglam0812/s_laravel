-- 1. Lấy danh sách người dùng theo thứ tự Alphabet (A->Z)
SELECT * FROM users ORDER BY user_name ASC;

-- 2. Lấy 7 người dùng đầu tiên theo thứ tự Alphabet (A->Z)
SELECT * FROM users ORDER BY user_name ASC LIMIT 7;

-- 3. Lấy danh sách người dùng có chữ 'a' trong tên
SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;

-- 4. Lấy danh sách người dùng có tên bắt đầu bằng chữ 'm'
SELECT * FROM users WHERE user_name LIKE 'm%' ORDER BY user_name ASC;

-- 5. Lấy danh sách người dùng có tên kết thúc bằng chữ 'i'
SELECT * FROM users WHERE user_name LIKE '%i' ORDER BY user_name ASC;

-- 6. Lấy danh sách người dùng có email là Gmail
SELECT * FROM users WHERE user_email LIKE '%@gmail.com';

-- 7. Lấy danh sách người dùng có email Gmail và tên bắt đầu bằng chữ 'm'
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';

-- 8. Lấy danh sách người dùng có email Gmail, tên có chữ 'i' và tên dài hơn 5 ký tự
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE '%i%' AND LENGTH(user_name) > 5;

-- 9. Lấy danh sách người dùng có tên chứa 'a', độ dài từ 5-9, email Gmail, tên email chứa 'i'
SELECT * FROM users 
WHERE user_name LIKE '%a%'
AND LENGTH(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND SUBSTRING_INDEX(user_email, '@', 1) LIKE '%i%';

-- 10. Lấy danh sách người dùng theo các điều kiện phức tạp hơn
SELECT * FROM users 
WHERE (user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9)
   OR (user_name LIKE '%i%' AND LENGTH(user_name) < 9)
   OR (user_email LIKE '%@gmail.com' AND SUBSTRING_INDEX(user_email, '@', 1) LIKE '%i%');
