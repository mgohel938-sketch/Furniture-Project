<%@ Page Title="FurniShop - Shop Luxury Catalog" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="FurniShop.Shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Luxury Furniture Collection</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Shop</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="display: grid; grid-template-columns: 280px 1fr; gap: 2.5rem;">
                
                <!-- Filters Sidebar -->
                <aside style="background: var(--clr-bg-card); padding: 1.75rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); height: fit-content;">
                    <h3 style="font-size: 1.2rem; margin-bottom: 1.5rem; padding-bottom: 0.75rem; border-bottom: 1px solid var(--clr-border);">Filter Collection</h3>
                    
                    <!-- Search Input -->
                    <div class="form-group">
                        <label class="form-label"><i class="fa-solid fa-magnifying-glass"></i> Search Products</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name..."></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary btn-sm" style="margin-top: 0.5rem; width: 100%;" />
                    </div>

                    <!-- Category Filter -->
                    <div class="form-group" style="margin-top: 1.5rem;">
                        <label class="form-label">Categories</label>
                        <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                            <a href="Shop.aspx" class="btn btn-outline btn-sm" style="text-align:left; display:block;">All Furniture</a>
                            <a href="Shop.aspx?category=Sofa" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Sofa</a>
                            <a href="Shop.aspx?category=Bed" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Bed</a>
                            <a href="Shop.aspx?category=Chair" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Chair</a>
                            <a href="Shop.aspx?category=Table" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Table</a>
                            <a href="Shop.aspx?category=Dining" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Dining</a>
                            <a href="Shop.aspx?category=Wardrobe" class="btn btn-outline btn-sm" style="text-align:left; display:block;">Wardrobe</a>
                        </div>
                    </div>
                </aside>

                <!-- Shop Main Content -->
                <div>
                    <div style="margin-bottom: 1.5rem;">
                        <asp:Label ID="lblTitle" runat="server" Font-Size="Large" Font-Bold="true"></asp:Label>
                    </div>

                    <!-- Products Grid Repeater -->
                    <div class="products-grid">
                        <asp:Repeater ID="rptrProducts" runat="server">
                            <ItemTemplate>
                                <div class="product-card">
                                    <div class="product-thumb">
                                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80';" style="width: 100%; height: 260px; object-fit: cover;">
                                    </div>
                                    <div class="product-info">
                                        <span class="product-category"><%# Eval("Category") %></span>
                                        <h3 class="product-title">
                                            <a href='ProductDetails.aspx?pid=<%# Eval("Id") %>'><%# Eval("ProductName") %></a>
                                        </h3>
                                        <div class="product-price">&#8377;<%# Eval("Price") %></div>
                                        <div style="margin-top: 1rem;">
                                            <a href='ProductDetails.aspx?pid=<%# Eval("Id") %>' class="btn btn-primary btn-sm" style="width:100%; text-align:center; display:block;">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
