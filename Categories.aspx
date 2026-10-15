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

            <div class="categories-grid" id="full-categories-grid">
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderFullCategories();
        });

        function renderFullCategories() {
            const container = document.getElementById('full-categories-grid');
            if (!container) return;
            const categories = db.getCategories();
            const products = db.getProducts();

            container.innerHTML = categories.map(cat => {
                const count = products.filter(p => p.category === cat.name).length;
                return `
                    <div class="category-card" onclick="window.location.href='Shop.aspx?category=${encodeURIComponent(cat.name)}'">
                        <img src="${cat.image}" alt="${cat.name}">
                        <div class="category-overlay">
                            <h3 class="category-title">${cat.name}</h3>
                            <div class="category-count"><i class="fa-solid ${cat.icon || 'fa-tag'}"></i> ${count} Available Products</div>
                            <p style="font-size:0.85rem; color: var(--clr-border); margin-top:0.35rem;">${cat.description}</p>
                        </div>
                    </div>
                `;
            }).join('');
        }
    </script>
</asp:Content>
