<%@ Page Title="FurniShop - My Account Profile" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FurniShop.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">My Account</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Profile</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="display: grid; grid-template-columns: 280px 1fr; gap: 3rem;">
                <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); height: fit-content;">
                    <div style="text-align: center; margin-bottom: 2rem; padding-bottom: 1.5rem; border-bottom: 1px solid var(--clr-border);">
                        <div style="width: 70px; height: 70px; border-radius: 50%; background: var(--clr-accent); color: white; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: 700; margin: 0 auto 1rem;">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <h3 style="font-size: 1.2rem;"><asp:Label ID="lblProfileName" runat="server"></asp:Label></h3>
                        <div style="font-size: 0.85rem; color: var(--clr-text-muted);"><asp:Label ID="lblProfileEmail" runat="server"></asp:Label></div>
                    </div>

                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <a href="MyOrders.aspx" class="btn btn-outline btn-sm" style="width:100%;"><i class="fa-solid fa-box"></i> My Orders</a>
                        <asp:Button ID="btnLogout" runat="server" Text="Sign Out" OnClick="btnLogout_Click" CssClass="btn btn-outline btn-sm" ForeColor="Red" style="width:100%; margin-top: 1rem;" />
                    </div>
                </div>

                <div style="background: var(--clr-bg-card); padding: 2.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border);">
                    <h3 style="font-size: 1.4rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid var(--clr-border);">Edit Personal Information</h3>

                    <div style="margin-bottom: 1rem;">
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email Address (Read Only)</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnUpdate" runat="server" Text="Save Profile Details" OnClick="btnUpdate_Click" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
