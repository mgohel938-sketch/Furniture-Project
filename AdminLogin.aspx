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
                    <div style="margin-bottom: 1rem; text-align: center;">
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Admin Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="admin@furnishop.com"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Admin Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Access Dashboard" OnClick="btnLogin_Click" CssClass="btn btn-accent btn-lg" style="width: 100%; margin-top: 1rem;" />

                    <div style="text-align: center; margin-top: 1.5rem;">
                        <a href="Index.aspx" style="color: var(--admin-accent); font-size: 0.9rem;"><i class="fa-solid fa-arrow-left"></i> Return to Storefront</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
