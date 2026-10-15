<%@ Page Title="Admin Profile - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="FurniShop.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card" style="max-width: 600px; margin: 0 auto;">
        <div class="admin-card-header">
            <h2>Super Admin Account Credentials</h2>
        </div>
        <div class="admin-card-body">
            <div id="admin-prof-form">
                <div class="form-group">
                    <label class="form-label">Admin Name</label>
                    <input type="text" id="admin-prof-name" class="form-control" required value="Admin Manager">
                </div>

                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" id="admin-prof-email" class="form-control" required value="admin@furnishop.com">
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" id="admin-prof-pass" class="form-control" required value="admin123">
                </div>

                <button type="button" onclick="handleAdminProfileUpdate()" class="btn btn-accent btn-lg" style="width: 100%;">Update Admin Profile</button>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        function handleAdminProfileUpdate() {
            const name = document.getElementById('admin-prof-name').value;
            const email = document.getElementById('admin-prof-email').value;

            if (!name || !email) {
                alert('Please enter name and email');
                return;
            }

            const session = { name, email, role: 'Super Admin' };
            localStorage.setItem(DB_KEYS.ADMIN_SESSION, JSON.stringify(session));
            alert('Admin Profile updated successfully!');
            renderAdminTopbar();
        }
    </script>
</asp:Content>
