<%@ Page Title="Admin Profile - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="FurniShop.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card" style="max-width: 600px; margin: 0 auto;">
        <div class="admin-card-header">
            <h2>Super Admin Account Credentials</h2>
        </div>
        <div class="admin-card-body">
            <div style="margin-bottom: 1rem;">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
            </div>

            <div class="form-group">
                <label class="form-label">Admin Name</label>
                <asp:TextBox ID="txtAdminName" runat="server" CssClass="form-control" Text="Admin Manager"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtAdminEmail" runat="server" CssClass="form-control" Text="admin@furnishop.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtAdminPass" runat="server" TextMode="Password" CssClass="form-control" Text="admin123"></asp:TextBox>
            </div>

            <asp:Button ID="btnUpdateAdmin" runat="server" Text="Update Admin Profile" OnClick="btnUpdateAdmin_Click" CssClass="btn btn-accent btn-lg" style="width: 100%;" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
