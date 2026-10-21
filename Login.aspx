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
                    <div style="margin-bottom: 1rem; text-align: center;">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="milan@example.com"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder=" enter password"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" CssClass="btn btn-primary btn-lg" style="width: 100%; margin-bottom: 1.5rem;" />

                    <div style="text-align: center; font-size: 0.9rem; color: var(--clr-text-muted);">
                        Don't have an account? <a href="Register.aspx" style="color: var(--clr-accent); font-weight:700;">Create Account</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
