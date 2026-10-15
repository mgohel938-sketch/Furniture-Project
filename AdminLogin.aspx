<%@ Page Title="FurniShop Admin - Portal Login" Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="FurniShop.AdminLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FurniShop Admin - Portal Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body class="admin-body">
    <form id="formAdminLogin" runat="server">
        <div class="admin-login-wrapper">
            <div class="admin-login-card">
                <div style="text-align: center; margin-bottom: 2rem;">
                    <div style="font-family: var(--font-heading); font-size: 2.25rem; font-weight: 700; color: var(--admin-text-main);">
                        <i class="fa-solid fa-couch" style="color: var(--admin-accent);"></i> Furni<span>Shop</span>
                    </div>
                    <div style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 2px; color: var(--admin-accent); font-weight:700; margin-top: 0.25rem;">
                        Admin Management Console
                    </div>
                </div>

                <div id="admin-login-form">
                    <div class="form-group">
                        <label class="form-label">Admin Email</label>
                        <input type="email" id="admin-email" class="form-control" required placeholder="admin@furnishop.com">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Admin Password</label>
                        <input type="password" id="admin-pass" class="form-control" required placeholder="••••••••">
                    </div>

                    <button type="button" onclick="handleAdminLoginSubmit()" class="btn btn-accent btn-lg" style="width: 100%; margin-bottom: 1rem;">
                        Access Dashboard <i class="fa-solid fa-right-to-bracket"></i>
                    </button>

                    <button type="button" onclick="fillDemoAdmin()" class="btn btn-outline btn-sm" style="width: 100%;">
                        <i class="fa-solid fa-key"></i> Fill Demo Admin Credentials
                    </button>
                </div>
            </div>
        </div>

        <script src="js/db.js"></script>
        <script src="js/admin.js"></script>
        <script>
            function fillDemoAdmin() {
                document.getElementById('admin-email').value = 'admin@furnishop.com';
                document.getElementById('admin-pass').value = 'admin123';
            }

            function handleAdminLoginSubmit() {
                const email = document.getElementById('admin-email').value;
                const pass = document.getElementById('admin-pass').value;

                if (!email || !pass) {
                    alert('Please enter email and password');
                    return;
                }

                const res = db.loginAdmin(email, pass);
                if (res.success) {
                    window.location.href = 'AdminDashboard.aspx';
                } else {
                    alert(res.message);
                }
            }
        </script>
    </form>
</body>
</html>
