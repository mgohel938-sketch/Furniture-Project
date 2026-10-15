<%--<%@ Page Title="FurniShop - Premium Luxury Furniture E-Commerce" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="FurniShop.Index" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <!-- Hero Section -->
        <section class="hero-section" style="background: linear-gradient(rgba(26,24,22,0.5), rgba(26,24,22,0.5)), url('https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=1920&q=80') center/cover no-repeat; padding: 10rem 0; color: white; text-align: center;">
            <div class="container">
                <span class="section-subtitle" style="color: var(--clr-accent);">Handcrafted Italian & Nordic Designs</span>
                <h1 style="font-size: 3.8rem; color: white; max-width: 900px; margin: 1rem auto 1.5rem;">Elevate Your Architectural Sanctuary</h1>
                <p style="font-size: 1.2rem; max-width: 650px; margin: 0 auto 2.5rem; color: rgba(255,255,255,0.9);">Discover our curated collection of luxury velvet sofas, Carrara marble tables, and solid walnut dining pieces engineered for timeless elegance.</p>
                <div style="display:flex; justify-content:center; gap: 1.25rem; flex-wrap: wrap;">
                    <a href="Shop.aspx" class="btn btn-accent btn-lg">Shop Now <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="Categories.aspx" class="btn btn-outline btn-lg" style="border-color: white; color: white;">Explore Categories</a>
                </div>
            </div>
        </section>

        <!-- Categories Section -->
        <section style="padding: 5rem 0; background: var(--clr-bg-main);">
            <div class="container">
                <div class="section-title-wrap">
                    <span class="section-subtitle">Curated Categories</span>
                    <h2 class="section-title">Explore By Room & Style</h2>
                    <p>Select a category to browse our artisanal luxury pieces tailored for modern living.</p>
                </div>
                <div class="categories-grid" id="home-categories-grid">
                </div>
            </div>
        </section>

        <!-- Featured Luxury Products -->
        <section style="padding: 5rem 0; background: var(--clr-bg-alt);">
            <div class="container">
                <div class="section-title-wrap">
                    <span class="section-subtitle">Featured Masterpieces</span>
                    <h2 class="section-title">Trending Luxury Collections</h2>
                    <p>Hand-picked statement pieces designed by award-winning European interior architects.</p>
                </div>
                <div class="products-grid" id="home-featured-products">
                </div>
                <div style="text-align: center; margin-top: 3.5rem;">
                    <a href="Shop.aspx" class="btn btn-primary btn-lg">View All Products <i class="fa-solid fa-store"></i></a>
                </div>
            </div>
        </section>

        <!-- Brand Values / Services Banner -->
        <section style="padding: 5rem 0; background: var(--clr-bg-dark); color: white;">
            <div class="container">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 2.5rem; text-align: center;">
                    <div>
                        <i class="fa-solid fa-truck-ramp-box" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 1.2rem;"></i>
                        <h3 style="color: white; font-size: 1.25rem; margin-bottom: 0.5rem;">White-Glove Delivery</h3>
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Insured room placement, unboxing, and complimentary assembly by certified technicians.</p>
                    </div>
                    <div>
                        <i class="fa-solid fa-award" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 1.2rem;"></i>
                        <h3 style="color: white; font-size: 1.25rem; margin-bottom: 0.5rem;">10-Year Craftsmanship</h3>
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Every solid hardwood frame and Italian leather cushion is backed by our decade guarantee.</p>
                    </div>
                    <div>
                        <i class="fa-solid fa-compass-drafting" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 1.2rem;"></i>
                        <h3 style="color: white; font-size: 1.25rem; margin-bottom: 0.5rem;">Design Concierge</h3>
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Schedule 1-on-1 consultations with our senior interior architects to customize your home.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderHomeCategories();
            renderHomeFeaturedProducts();
        });

        function renderHomeCategories() {
            const container = document.getElementById('home-categories-grid');
            if (!container) return;
            const categories = db.getCategories().slice(0, 4);

            container.innerHTML = categories.map(cat => `
                <div class="category-card" onclick="window.location.href='Shop.aspx?category=${encodeURIComponent(cat.name)}'">
                    <img src="${cat.image}" alt="${cat.name}">
                    <div class="category-overlay">
                        <h3 class="category-title">${cat.name}</h3>
                        <div class="category-count">${cat.description}</div>
                    </div>
                </div>
            `).join('');
        }

        function renderHomeFeaturedProducts() {
            const container = document.getElementById('home-featured-products');
            if (!container) return;
            const products = db.getProducts().slice(0, 4);

            container.innerHTML = products.map(prod => {
                const isWish = db.isInWishlist(prod.id);
                const finalPrice = prod.discount ? prod.price * (1 - prod.discount/100) : prod.price;
                return `
                    <div class="product-card">
                        <div class="product-img-wrap">
                            <img src="${prod.image}" alt="${prod.name}">
                            <div class="product-badges">
                                ${prod.discount ? `<span class="badge badge-discount">-${prod.discount}%</span>` : ''}
                                ${prod.stock <= 0 ? `<span class="badge badge-out">Out of Stock</span>` : (prod.stock <= 3 ? `<span class="badge badge-stock">Only ${prod.stock} Left</span>` : '')}
                            </div>
                            <button type="button" class="wishlist-btn-card ${isWish ? 'active' : ''}" onclick="handleToggleWishlist('${prod.id}', this)" title="Add to Wishlist">
                                <i class="fa-solid fa-heart"></i>
                            </button>
                        </div>
                        <div class="product-info">
                            <span class="product-category">${prod.category}</span>
                            <h3 class="product-title"><a href="ProductDetails.aspx?id=${prod.id}">${prod.name}</a></h3>
                            <div class="product-rating">
                                ${'<i class="fa-solid fa-star"></i>'.repeat(Math.floor(prod.rating))}
                                <span class="rating-count">(${prod.reviewCount})</span>
                            </div>
                            <div class="product-price-row">
                                <div class="price-wrap">
                                    <span class="price-current">${formatPrice(finalPrice)}</span>
                                    ${prod.discount ? `<span class="price-original">${formatPrice(prod.price)}</span>` : ''}
                                </div>
                            </div>
                            <div class="card-actions">
                                <a href="ProductDetails.aspx?id=${prod.id}" class="btn btn-outline btn-sm">View Details</a>
                                <button type="button" onclick="handleAddToCart('${prod.id}')" class="btn btn-primary btn-sm" ${prod.stock <= 0 ? 'disabled style="opacity:0.5; cursor:not-allowed;"' : ''}>
                                    <i class="fa-solid fa-bag-shopping"></i> Add
                                </button>
                            </div>
                        </div>
                    </div>
                `;
            }).join('');
        }
    </script>
</asp:Content>
