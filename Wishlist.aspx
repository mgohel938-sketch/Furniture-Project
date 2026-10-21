<%@ Page Title="FurniShop - Saved Wishlist" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="FurniShop.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">My Wishlist</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Wishlist</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="text-align: center; padding: 4rem 1rem;">
                <i class="fa-regular fa-heart" style="font-size: 4rem; color: var(--clr-text-light); margin-bottom: 1.5rem;"></i>
                <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">Browse Our Collections</h2>
                <p style="color: var(--clr-text-muted); margin-bottom: 2rem;">Explore luxury furniture and add items directly to your cart.</p>
                <a href="Shop.aspx" class="btn btn-primary btn-lg">Explore Catalog</a>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
