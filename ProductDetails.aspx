<%@ Page Title="FurniShop - Product Details" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="FurniShop.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Product Details</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <a href="Shop.aspx">Shop</a> / <span>Details</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding: 4rem 0 6rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: start;">
                <div>
                    <div style="aspect-ratio: 4/3; border-radius: var(--radius-md); overflow: hidden; background: var(--clr-bg-alt); border: 1px solid var(--clr-border);">
                        <asp:Image ID="imgProduct" runat="server" style="width: 100%; height: 100%; object-fit: cover;" />
                    </div>
                </div>

                <div>
                    <div class="product-category">
                        <asp:Label ID="lblCategory" runat="server"></asp:Label>
                    </div>
                    <h1 style="font-size: 2.5rem; margin: 0.5rem 0 1rem;">
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </h1>

                    <div style="font-size: 2.25rem; font-weight: 800; color: var(--clr-text-main); margin-bottom: 1.5rem;">
                        &#8377;<asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </div>

                    <p style="color: var(--clr-text-muted); font-size: 1.05rem; margin-bottom: 2rem; line-height: 1.8;">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </p>

                    <div style="background: var(--clr-bg-alt); padding: 1.25rem; border-radius: var(--radius-sm); margin-bottom: 2rem; font-size: 0.9rem;">
                        <div><strong>Stock Available:</strong> <asp:Label ID="lblStock" runat="server"></asp:Label> units</div>
                        <div><strong>Craftsmanship:</strong> Premium Handcrafted Design</div>
                    </div>

                    <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 2rem;">
                        <label class="form-label" style="margin: 0; font-weight: 600;">Quantity:</label>
                        <asp:TextBox ID="txtQty" runat="server" Text="1" TextMode="Number" min="1" CssClass="form-control" style="width: 80px; text-align: center; font-weight: 700;"></asp:TextBox>
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" CssClass="btn btn-primary" />
                        <a href="Shop.aspx" class="btn btn-outline">Back to Catalog</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
