<%@ Page Title="FurniShop - Sign In" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FurniShop.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="container" style="padding: 5rem 0; display: flex; justify-content: center;">
            <div style="background: var(--clr-bg-card); border-radius: var(--radius-lg); border: 1px solid var(--clr-border); box-shadow: var(--shadow-lg); padding: 3.5rem; width: 100%; max-width: 480px;">
                <div style="text-align: center; margin-bottom: 2rem;">
                    <i class="fa-solid fa-couch" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 0.5rem;"></i>
                    <h2 style="font-size: 2rem;">Welcome Back</h2>
                    <p style="color: var(--clr-text-muted); font-size: 0.9rem;">Sign in to access your saved wishlist and orders.</p>
                </div>

                <div id="login-form">
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" id="login-email" class="form-control" required placeholder="eleanor@example.com">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" id="login-password" class="form-control" required placeholder="••••••••">
                    </div>

                    <button type="button" onclick="handleCustomerLogin()" class="btn btn-primary btn-lg" style="width: 100%; margin-bottom: 1rem;">Sign In</button>
                    
                    <button type="button" onclick="fillDemoCustomer()" class="btn btn-outline btn-sm" style="width: 100%; margin-bottom: 1.5rem;">
                        <i class="fa-solid fa-user-check"></i> Fill Demo Customer Credentials
                    </button>

                    <div style="text-align: center; font-size: 0.9rem; color: var(--clr-text-muted);">
                        Don't have an account? <a href="Register.aspx" style="color: var(--clr-accent); font-weight:700;">Create Account</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function fillDemoCustomer() {
            document.getElementById('login-email').value = 'eleanor@example.com';
            document.getElementById('login-password').value = 'password123';
        }

        function handleCustomerLogin() {
            const email = document.getElementById('login-email').value;
            const pass = document.getElementById('login-password').value;

            if (!email || !pass) {
                showToast('Please enter both email and password', 'error');
                return;
            }

            const result = db.loginUser(email, pass);
            if (result.success) {
                showToast(`Welcome back, ${result.user.name}!`, 'success');
                setTimeout(() => {
                    window.location.href = 'Index.aspx';
                }, 600);
            } else {
                showToast(result.message, 'error');
            }
        }
    </script>
</asp:Content>
