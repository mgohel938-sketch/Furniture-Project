/* ==========================================================================
   FURNISHOP - CUSTOMER WEBSITE CORE SCRIPT & UI HANDLERS (ASP.NET ASPX)
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
    renderHeader();
    renderFooter();
    updateBadges();
});

// Toast notification helper
function showToast(message, type = 'info') {
    let container = document.querySelector('.toast-container');
    if (!container) {
        container = document.createElement('div');
        container.className = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    let iconClass = 'fa-circle-info';
    if (type === 'success') iconClass = 'fa-circle-check';
    if (type === 'error') iconClass = 'fa-circle-xmark';

    toast.innerHTML = `
        <i class="fa-solid ${iconClass}"></i>
        <span>${message}</span>
    `;

    container.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateX(100%)';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// Format price with currency setting
function formatPrice(amount) {
    const settings = db.getSettings();
    return `${settings.currency}${parseFloat(amount).toLocaleString(undefined, { minimumFractionDigits: 0, maximumFractionDigits: 2 })}`;
}

// Update Wishlist & Cart count badges
function updateBadges() {
    const cartCount = db.getCart().reduce((sum, item) => sum + item.quantity, 0);
    const wishlistCount = db.getWishlist().length;

    const cartBadge = document.getElementById('nav-cart-count');
    const wishlistBadge = document.getElementById('nav-wishlist-count');

    if (cartBadge) cartBadge.textContent = cartCount;
    if (wishlistBadge) wishlistBadge.textContent = wishlistCount;
}

// Global Cart & Wishlist handlers
function handleAddToCart(productId, quantity = 1) {
    const success = db.addToCart(productId, quantity);
    if (success) {
        updateBadges();
        showToast('Product added to your cart!', 'success');
    } else {
        showToast('Failed to add product to cart', 'error');
    }
}

function handleToggleWishlist(productId, btnElement) {
    const added = db.toggleWishlist(productId);
    updateBadges();
    if (btnElement) {
        if (added) btnElement.classList.add('active');
        else btnElement.classList.remove('active');
    }
    showToast(added ? 'Added to your Wishlist!' : 'Removed from Wishlist', 'info');
}

// Header Navigation HTML Injection
function renderHeader() {
    const headerContainer = document.getElementById('main-header');
    if (!headerContainer) return;

    const currentUser = db.getCurrentUser();
    const currentPage = (window.location.pathname.split('/').pop() || 'Index.aspx').toLowerCase();

    headerContainer.innerHTML = `
        <div class="header-top">
            <div class="container header-top-inner">
                <div class="header-contact-info">
                    <span><i class="fa-solid fa-phone"></i> +1 (800) 458-7647</span>
                    <span><i class="fa-solid fa-envelope"></i> concierge@furnishop.com</span>
                </div>
                <div class="header-top-links">
                    <a href="About.aspx">About Us</a>
                    <a href="Services.aspx">White-Glove Services</a>
                    <a href="Contact.aspx">Contact</a>
                    <a href="AdminLogin.aspx" style="color: var(--clr-accent); font-weight:600;"><i class="fa-solid fa-lock"></i> Admin Portal</a>
                </div>
            </div>
        </div>
        <nav class="navbar">
            <div class="container nav-container">
                <a href="Index.aspx" class="brand-logo">
                    <i class="fa-solid fa-couch"></i> Furni<span>Shop</span>
                </a>
                <ul class="nav-links">
                    <li><a href="Index.aspx" class="nav-link ${currentPage === 'index.aspx' ? 'active' : ''}">Home</a></li>
                    <li><a href="Shop.aspx" class="nav-link ${currentPage === 'shop.aspx' ? 'active' : ''}">Shop</a></li>
                    <li><a href="Categories.aspx" class="nav-link ${currentPage === 'categories.aspx' ? 'active' : ''}">Categories</a></li>
                    <li><a href="About.aspx" class="nav-link ${currentPage === 'about.aspx' ? 'active' : ''}">About</a></li>
                    <li><a href="Services.aspx" class="nav-link ${currentPage === 'services.aspx' ? 'active' : ''}">Services</a></li>
                    <li><a href="Contact.aspx" class="nav-link ${currentPage === 'contact.aspx' ? 'active' : ''}">Contact</a></li>
                </ul>
                <div class="nav-actions">
                    <a href="Wishlist.aspx" class="nav-icon-btn" title="Wishlist">
                        <i class="fa-regular fa-heart"></i>
                        <span class="badge-count" id="nav-wishlist-count">0</span>
                    </a>
                    <a href="Cart.aspx" class="nav-icon-btn" title="Shopping Cart">
                        <i class="fa-solid fa-bag-shopping"></i>
                        <span class="badge-count" id="nav-cart-count">0</span>
                    </a>
                    <div class="user-menu-wrap">
                        <a href="${currentUser ? 'Profile.aspx' : 'Login.aspx'}" class="nav-icon-btn" title="${currentUser ? currentUser.name : 'Account Login'}">
                            <i class="fa-regular fa-user"></i>
                        </a>
                        <div class="user-dropdown">
                            ${currentUser ? `
                                <div style="padding: 0.75rem 1.25rem; border-bottom: 1px solid var(--clr-border);">
                                    <div style="font-weight: 700;">${currentUser.name}</div>
                                    <div style="font-size: 0.75rem; color: var(--clr-text-muted);">${currentUser.email}</div>
                                </div>
                                <a href="Profile.aspx"><i class="fa-solid fa-user-gear"></i> My Profile</a>
                                <a href="MyOrders.aspx"><i class="fa-solid fa-box"></i> My Orders</a>
                                <a href="Wishlist.aspx"><i class="fa-solid fa-heart"></i> My Wishlist</a>
                                <button type="button" onclick="handleLogout()"><i class="fa-solid fa-right-from-bracket"></i> Logout</button>
                            ` : `
                                <a href="Login.aspx"><i class="fa-solid fa-right-to-bracket"></i> Sign In</a>
                                <a href="Register.aspx"><i class="fa-solid fa-user-plus"></i> Create Account</a>
                            `}
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    `;
}

function handleLogout() {
    db.logoutUser();
    showToast('Successfully logged out', 'info');
    setTimeout(() => {
        window.location.href = 'Index.aspx';
    }, 500);
}

// Footer HTML Injection
function renderFooter() {
    const footerContainer = document.getElementById('main-footer');
    if (!footerContainer) return;

    footerContainer.innerHTML = `
        <div class="container footer-grid">
            <div class="footer-brand">
                <a href="Index.aspx" class="brand-logo" style="color: #ffffff;">
                    <i class="fa-solid fa-couch"></i> Furni<span>Shop</span>
                </a>
                <p>Curating bespoke, luxury furniture for world-class architectural spaces. Designed with passion, crafted with perfection.</p>
                <div class="social-links">
                    <a href="#" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fa-brands fa-pinterest-p"></i></a>
                    <a href="#" class="social-icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fa-brands fa-houzz"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h4>Explore Collections</h4>
                <ul>
                    <li><a href="Shop.aspx?category=Sofa">Italian Leather Sofas</a></li>
                    <li><a href="Shop.aspx?category=Bed">Velvet Bed Frames</a></li>
                    <li><a href="Shop.aspx?category=Table">Marble Coffee Tables</a></li>
                    <li><a href="Shop.aspx?category=Dining">Solid Walnut Dining</a></li>
                    <li><a href="Shop.aspx?category=Chair">Lounge & Armchairs</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Customer Service</h4>
                <ul>
                    <li><a href="Services.aspx">White-Glove Delivery</a></li>
                    <li><a href="Services.aspx">Interior Design Concierge</a></li>
                    <li><a href="MyOrders.aspx">Track Order Status</a></li>
                    <li><a href="Contact.aspx">Returns & Warranty</a></li>
                    <li><a href="Contact.aspx">FAQs</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Private VIP Lounge</h4>
                <p style="font-size: 0.875rem; color: var(--clr-text-light); margin-bottom: 1rem;">Subscribe to receive exclusive access to new luxury arrivals and private sales.</p>
                <div style="display:flex; gap:0.5rem;">
                    <input type="email" id="footer-newsletter-email" placeholder="Your email address" style="padding: 0.75rem; border-radius: 4px; border: 1px solid var(--clr-border-dark); background: var(--clr-bg-dark-surface); color: white; width:100%;">
                    <button type="button" onclick="if(document.getElementById('footer-newsletter-email').value) { showToast('Subscribed to VIP Newsletter!', 'success'); document.getElementById('footer-newsletter-email').value=''; } else { showToast('Please enter an email address', 'error'); }" class="btn btn-accent btn-sm">Join</button>
                </div>
            </div>
        </div>
        <div class="container footer-bottom">
            <div>&copy; ${new Date().getFullYear()} FurniShop Luxury E-Commerce Inc. All rights reserved.</div>
            <div>
                <a href="AdminLogin.aspx" style="color: var(--clr-accent); margin-right: 1.5rem;"><i class="fa-solid fa-lock"></i> Admin Panel</a>
                <a href="#" style="margin-right: 1rem;">Privacy Policy</a>
                <a href="#">Terms of Concierge</a>
            </div>
        </div>
    `;
}
