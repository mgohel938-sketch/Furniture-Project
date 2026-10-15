<%@ Page Title="FurniShop - Create Account" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FurniShop.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="container" style="padding: 5rem 0; display: flex; justify-content: center;">
            <div style="background: var(--clr-bg-card); border-radius: var(--radius-lg); border: 1px solid var(--clr-border); box-shadow: var(--shadow-lg); padding: 3.5rem; width: 100%; max-width: 520px;">
                <div style="text-align: center; margin-bottom: 2rem;">
                    <i class="fa-solid fa-user-plus" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 0.5rem;"></i>
                    <h2 style="font-size: 2rem;">Create Your Account</h2>
                    <p style="color: var(--clr-text-muted); font-size: 0.9rem;">Join the FurniShop private concierge club.</p>
                </div>

                <div id="register-form">
                    <div style="margin-bottom: 1rem; text-align: center;">
                        <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Full Name *</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g. Julian Thorne" required="required"></asp:TextBox>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label class="form-label">Email Address *</label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="julian@example.com" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" CssClass="form-control" placeholder="+1 (555) 0192"></asp:TextBox>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label class="form-label">Password *</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Confirm Password *</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••" required="required"></asp:TextBox>
                        </div>
                    </div>

                    <asp:Button ID="btnRegister" runat="server" Text="Register Account" OnClick="btnRegister_Click" CausesValidation="false" CssClass="btn btn-primary btn-lg" style="width: 100%; margin-bottom: 1.5rem;" />

                    <div style="text-align: center; font-size: 0.9rem; color: var(--clr-text-muted);">
                        Already have an account? <a href="Login.aspx" style="color: var(--clr-accent); font-weight:700;">Sign In</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
