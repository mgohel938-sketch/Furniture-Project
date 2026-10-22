<%@ Page Title="FurniShop - Premium Luxury Furniture E-Commerce" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="FurniShop.Index" %>

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
                <div class="categories-grid">
                    <div class="category-card" onclick="window.location.href='Shop.aspx?category=Sofa'">
                        <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80" alt="Living Room">
                        <div class="category-overlay">
                            <h3 class="category-title">Living Room Sofas</h3>
                            <div class="category-count">Plush velour and top-grain Italian leather</div>
                        </div>
                    </div>
                    <div class="category-card" onclick="window.location.href='Shop.aspx?category=Dining'">
                        <img src="https://images.unsplash.com/photo-1617806118233-18e1de247200?auto=format&fit=crop&w=800&q=80" alt="Dining Room">
                        <div class="category-overlay">
                            <h3 class="category-title">Dining Room</h3>
                            <div class="category-count">Carrara marble and solid American walnut tables</div>
                        </div>
                    </div>
                    <div class="category-card" onclick="window.location.href='Shop.aspx?category=Bed'">
                        <img src="https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80" alt="Bedroom">
                        <div class="category-overlay">
                            <h3 class="category-title">Bedroom Suites</h3>
                            <div class="category-count">Floating bedframes and upholstered headboards</div>
                        </div>
                    </div>
                    <div class="category-card" onclick="window.location.href='Shop.aspx?category=Chair'">
                        <img src="https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?auto=format&fit=crop&w=800&q=80" alt="Lounge Chairs">
                        <div class="category-overlay">
                            <h3 class="category-title">Accent Chairs</h3>
                            <div class="category-count">Ergonomic swivel and brass-frame lounge chairs</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Luxury Products -->
        <section style="padding: 5rem 0; background: var(--clr-bg-alt);">
            <div class="container">
                <div class="section-title-wrap">
                    <span class="section-subtitle">Featured Masterpieces</span>
                    <h2 class="section-title">Trending Luxury Collections</h2>
                    <p>Hand-picked statement pieces designed for modern living.</p>
                </div>

                <div class="products-grid">
                    <asp:Repeater ID="rptrFeatured" runat="server">
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
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Insured room placement, unboxing, and complimentary assembly.</p>
                    </div>
                    <div>
                        <i class="fa-solid fa-award" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 1.2rem;"></i>
                        <h3 style="color: white; font-size: 1.25rem; margin-bottom: 0.5rem;">10-Year Craftsmanship</h3>
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Every solid hardwood frame and cushion is backed by our guarantee.</p>
                    </div>
                    <div>
                        <i class="fa-solid fa-compass-drafting" style="font-size: 2.5rem; color: var(--clr-accent); margin-bottom: 1.2rem;"></i>
                        <h3 style="color: white; font-size: 1.25rem; margin-bottom: 0.5rem;">Design Concierge</h3>
                        <p style="color: var(--clr-text-light); font-size: 0.9rem;">Consultations with our team to customize your home.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
