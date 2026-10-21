<%@ Page Title="FurniShop - Categories" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="FurniShop.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Furniture Categories</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Categories</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div class="section-title-wrap">
                <span class="section-subtitle">Architectural Living</span>
                <h2 class="section-title">Explore Collections By Category</h2>
                <p>Click any category to filter and browse our bespoke luxury pieces.</p>
            </div>

            <div class="categories-grid">
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Sofa'">
                    <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80" alt="Sofa">
                    <div class="category-overlay">
                        <h3 class="category-title">Sofas</h3>
                        <div class="category-count">Plush velour and top-grain Italian leather</div>
                    </div>
                </div>
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Bed'">
                    <img src="https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80" alt="Bed">
                    <div class="category-overlay">
                        <h3 class="category-title">Beds</h3>
                        <div class="category-count">Floating bedframes and upholstered headboards</div>
                    </div>
                </div>
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Dining'">
                    <img src="https://images.unsplash.com/photo-1617806118233-18e1de247200?auto=format&fit=crop&w=800&q=80" alt="Dining">
                    <div class="category-overlay">
                        <h3 class="category-title">Dining</h3>
                        <div class="category-count">Carrara marble and solid American walnut tables</div>
                    </div>
                </div>
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Chair'">
                    <img src="https://images.unsplash.com/photo-1580481077195-c990b79872e4?auto=format&fit=crop&w=800&q=80" alt="Chair">
                    <div class="category-overlay">
                        <h3 class="category-title">Chairs</h3>
                        <div class="category-count">Ergonomic swivel and brass-frame lounge chairs</div>
                    </div>
                </div>
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Table'">
                    <img src="https://images.unsplash.com/photo-1533090161767-e6ffed986c88?auto=format&fit=crop&w=800&q=80" alt="Table">
                    <div class="category-overlay">
                        <h3 class="category-title">Tables</h3>
                        <div class="category-count">Coffee tables, side tables, and console desks</div>
                    </div>
                </div>
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=Wardrobe'">
                    <img src="https://images.unsplash.com/photo-1595428774223-ef52624120d2?auto=format&fit=crop&w=800&q=80" alt="Wardrobe">
                    <div class="category-overlay">
                        <h3 class="category-title">Wardrobes</h3>
                        <div class="category-count">Luxury wood finishes and bespoke storage</div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
