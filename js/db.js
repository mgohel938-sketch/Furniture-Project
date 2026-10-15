/* ==========================================================================
   FURNISHOP - CENTRAL LOCALSTORAGE DATABASE ENGINE & DATA STORE
   ========================================================================== */

const DB_KEYS = {
    PRODUCTS: 'products',
    CATEGORIES: 'categories',
    USERS: 'users',
    CURRENT_USER: 'currentUser',
    CART: 'cart',
    WISHLIST: 'wishlist',
    ORDERS: 'orders',
    CUSTOMERS: 'customers',
    SUPPLIERS: 'suppliers',
    PAYMENTS: 'payments',
    SALES: 'sales',
    REVIEWS: 'reviews',
    OFFERS: 'offers',
    SETTINGS: 'settings',
    ADMIN_SESSION: 'adminSession'
};

// Initial Seed Data
const DEFAULT_SETTINGS = {
    websiteName: 'FurniShop Luxury',
    logoText: 'FurniShop',
    currency: '$',
    taxRate: 8,          // 8%
    deliveryCharge: 150, // $150 flat white-glove delivery
    lowStockLimit: 3
};

const DEFAULT_CATEGORIES = [
    { id: 'cat-sofa', name: 'Sofa', icon: 'fa-couch', image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80', description: 'Italian leather & modular luxury sofas' },
    { id: 'cat-bed', name: 'Bed', icon: 'fa-bed', image: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80', description: 'Velvet upholstered & king size bed frames' },
    { id: 'cat-chair', name: 'Chair', icon: 'fa-chair', image: 'https://images.unsplash.com/photo-1580481072645-022f9a6d8310?auto=format&fit=crop&w=800&q=80', description: 'Ergonomic lounge chairs & accent armchairs' },
    { id: 'cat-table', name: 'Table', icon: 'fa-table', image: 'https://images.unsplash.com/photo-1530018607912-eff2daa1bac4?auto=format&fit=crop&w=800&q=80', description: 'Solid walnut & Italian marble coffee tables' },
    { id: 'cat-dining', name: 'Dining', icon: 'fa-utensils', image: 'https://images.unsplash.com/photo-1615066390971-03e4e1c36ddf?auto=format&fit=crop&w=800&q=80', description: 'Artisanal dining sets & luxury tables' },
    { id: 'cat-wardrobe', name: 'Wardrobe', icon: 'fa-door-closed', image: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?auto=format&fit=crop&w=800&q=80', description: 'Custom fitted walk-in & wooden wardrobes' },
    { id: 'cat-office', name: 'Office Furniture', icon: 'fa-briefcase', image: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', description: 'Executive desks & premium leather office chairs' },
    { id: 'cat-living', name: 'Living Room', icon: 'fa-tv', image: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=800&q=80', description: 'Media consoles & complete living room suites' }
];

const DEFAULT_SUPPLIERS = [
    { id: 'sup-1', name: 'Milano Artisan Crafts', company: 'Milano Leather Co.', phone: '+1 555-0192', email: 'contact@milano-crafts.com', address: 'Milan, Italy', productsCount: 5 },
    { id: 'sup-2', name: 'Nordic Oak & Joinery', company: 'Nordic Timbers Group', phone: '+45 88-129384', email: 'sales@nordic-joinery.dk', address: 'Copenhagen, Denmark', productsCount: 4 },
    { id: 'sup-3', name: 'Verona Marble Works', company: 'Verona Stone S.p.A', phone: '+39 045-81293', email: 'info@veronamarble.it', address: 'Verona, Italy', productsCount: 3 }
];

const DEFAULT_PRODUCTS = [
    {
        id: 'prod-101',
        name: 'Aurelia Italian Velvet Sofa',
        category: 'Sofa',
        price: 2850,
        discount: 10,
        rating: 4.9,
        reviewCount: 14,
        stock: 8,
        supplierId: 'sup-1',
        image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80',
        material: 'Premium Velvet & Solid Oak Frame',
        dimensions: '88" W x 38" D x 32" H',
        color: 'Emerald Green',
        description: 'The Aurelia sofa blends timeless Italian silhouette with plush emerald velvet upholstery. Handcrafted by master artisans with high-resilience foam cushioning.',
        isFeatured: true
    },
    {
        id: 'prod-102',
        name: 'Verona Sculptural Marble Coffee Table',
        category: 'Table',
        price: 1420,
        discount: 0,
        rating: 4.8,
        reviewCount: 9,
        stock: 5,
        supplierId: 'sup-3',
        image: 'https://images.unsplash.com/photo-1530018607912-eff2daa1bac4?auto=format&fit=crop&w=800&q=80',
        material: 'Carrara Marble & Brushed Brass',
        dimensions: '48" L x 30" W x 16" H',
        color: 'White Marble / Gold',
        description: 'Carved from natural Carrara marble, the Verona coffee table showcases organic vein patterns mounted on a brushed champagne brass base.',
        isFeatured: true
    },
    {
        id: 'prod-103',
        name: 'Nordic Minimalist Oak King Bed',
        category: 'Bed',
        price: 3100,
        discount: 15,
        rating: 5.0,
        reviewCount: 22,
        stock: 4,
        supplierId: 'sup-2',
        image: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800&q=80',
        material: 'FSC-Certified Solid White Oak',
        dimensions: '82" W x 88" L x 46" H',
        color: 'Natural Oak',
        description: 'Embrace Scandinavian serenity with the Nordic King Bed. Clean lines, floating headboard profile, and seamless mortise-and-tenon joinery.',
        isFeatured: true
    },
    {
        id: 'prod-104',
        name: 'Eames Style Top-Grain Leather Lounge Chair',
        category: 'Chair',
        price: 1950,
        discount: 5,
        rating: 4.9,
        reviewCount: 31,
        stock: 2, // Low Stock example
        supplierId: 'sup-1',
        image: 'https://images.unsplash.com/photo-1580481072645-022f9a6d8310?auto=format&fit=crop&w=800&q=80',
        material: 'Walnut Plywood & Top-Grain Aniline Leather',
        dimensions: '33" W x 33" D x 32" H',
        color: 'Cognac Brown',
        description: 'An iconic symbol of mid-century luxury. Crafted with molded walnut veneer shells and supple cognac aniline leather cushions with Ottoman included.',
        isFeatured: true
    },
    {
        id: 'prod-105',
        name: 'Sienna 8-Seater Walnut Dining Table',
        category: 'Dining',
        price: 3600,
        discount: 0,
        rating: 4.7,
        reviewCount: 11,
        stock: 6,
        supplierId: 'sup-2',
        image: 'https://images.unsplash.com/photo-1615066390971-03e4e1c36ddf?auto=format&fit=crop&w=800&q=80',
        material: 'American Solid Black Walnut',
        dimensions: '96" L x 42" W x 30" H',
        color: 'Deep Walnut',
        description: 'Gather in grandeur around the Sienna Dining Table. Made from hand-selected live-edge black walnut planks with soft matte polyurethane finish.',
        isFeatured: true
    },
    {
        id: 'prod-106',
        name: 'Milano Executive Leather Desk',
        category: 'Office Furniture',
        price: 2450,
        discount: 0,
        rating: 4.8,
        reviewCount: 7,
        stock: 3,
        supplierId: 'sup-1',
        image: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80',
        material: 'Italian Saddle Leather & Dark Ash Wood',
        dimensions: '72" W x 34" D x 30" H',
        color: 'Charcoal Black',
        description: 'Command your workspace with the Milano Executive Desk. Features integrated leather writing inlay, wire routing channels, and soft-close drawers.',
        isFeatured: false
    },
    {
        id: 'prod-107',
        name: 'Monaco Fluted Glass Wardrobe',
        category: 'Wardrobe',
        price: 4200,
        discount: 20,
        rating: 4.9,
        reviewCount: 5,
        stock: 0, // Out of stock example
        supplierId: 'sup-3',
        image: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?auto=format&fit=crop&w=800&q=80',
        material: 'Fluted Tempered Glass & Anodized Aluminum',
        dimensions: '78" W x 24" D x 90" H',
        color: 'Bronze & Smoked Glass',
        description: 'Architectural precision meets elegant storage. The Monaco Wardrobe incorporates LED sensor backlighting and fluted smoked glass doors.',
        isFeatured: false
    },
    {
        id: 'prod-108',
        name: 'Kyoto Minimalist Living Console',
        category: 'Living Room',
        price: 1280,
        discount: 0,
        rating: 4.6,
        reviewCount: 16,
        stock: 12,
        supplierId: 'sup-2',
        image: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=800&q=80',
        material: 'Natural White Oak & Slatted Sliding Doors',
        dimensions: '70" W x 18" D x 22" H',
        color: 'Light Oak',
        description: 'Inspired by Japanese woodworking principles, the Kyoto console hides electronics behind slatted sliding screens that permit infrared remote signals.',
        isFeatured: false
    }
];

const DEFAULT_USERS = [
    {
        id: 'user-001',
        name: 'Eleanor Vance',
        email: 'eleanor@example.com',
        phone: '+1 555-0182',
        password: 'password123',
        address: '742 Evergreen Terrace, Suite 4B',
        city: 'New York',
        state: 'NY',
        pincode: '10001',
        ordersCount: 2,
        totalSpent: 4270,
        status: 'Active'
    }
];

const DEFAULT_OFFERS = [
    {
        id: 'off-1',
        name: 'Autumn Luxury Sale',
        discount: 15,
        category: 'Bed',
        startDate: '2026-09-01',
        endDate: '2026-10-31',
        status: 'Active'
    },
    {
        id: 'off-2',
        name: 'VIP Velvet Special',
        discount: 10,
        category: 'Sofa',
        startDate: '2026-09-15',
        endDate: '2026-10-15',
        status: 'Active'
    }
];

const DEFAULT_REVIEWS = [
    {
        id: 'rev-1',
        productId: 'prod-101',
        customerName: 'Marcus Sterling',
        rating: 5,
        comment: 'The emerald velvet is breathtaking in person. Extraordinary build quality!',
        date: '2026-09-20',
        status: 'Approved'
    },
    {
        id: 'rev-2',
        productId: 'prod-103',
        customerName: 'Sophia Lin',
        rating: 5,
        comment: 'Extremely sturdy solid oak frame. Delivery crew brought it up to our master suite with white-glove setup.',
        date: '2026-09-22',
        status: 'Approved'
    }
];

const DEFAULT_ORDERS = [
    {
        id: 'ORD-9021',
        customerId: 'user-001',
        customerName: 'Eleanor Vance',
        customerEmail: 'eleanor@example.com',
        customerPhone: '+1 555-0182',
        shippingAddress: '742 Evergreen Terrace, Suite 4B, New York, NY 10001',
        items: [
            { id: 'prod-101', name: 'Aurelia Italian Velvet Sofa', price: 2565, quantity: 1, image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80' },
            { id: 'prod-102', name: 'Verona Sculptural Marble Coffee Table', price: 1420, quantity: 1, image: 'https://images.unsplash.com/photo-1530018607912-eff2daa1bac4?auto=format&fit=crop&w=800&q=80' }
        ],
        subtotal: 3985,
        tax: 318.8,
        delivery: 150,
        total: 4453.8,
        paymentMethod: 'Credit Card',
        paymentStatus: 'Paid',
        orderStatus: 'Shipped',
        date: '2026-09-24'
    }
];

// DB Helper Module
class FurniDB {
    constructor() {
        this.init();
    }

    init() {
        if (!localStorage.getItem(DB_KEYS.SETTINGS)) {
            localStorage.setItem(DB_KEYS.SETTINGS, JSON.stringify(DEFAULT_SETTINGS));
        }
        if (!localStorage.getItem(DB_KEYS.CATEGORIES)) {
            localStorage.setItem(DB_KEYS.CATEGORIES, JSON.stringify(DEFAULT_CATEGORIES));
        }
        if (!localStorage.getItem(DB_KEYS.SUPPLIERS)) {
            localStorage.setItem(DB_KEYS.SUPPLIERS, JSON.stringify(DEFAULT_SUPPLIERS));
        }
        if (!localStorage.getItem(DB_KEYS.PRODUCTS)) {
            localStorage.setItem(DB_KEYS.PRODUCTS, JSON.stringify(DEFAULT_PRODUCTS));
        }
        if (!localStorage.getItem(DB_KEYS.USERS)) {
            localStorage.setItem(DB_KEYS.USERS, JSON.stringify(DEFAULT_USERS));
        }
        if (!localStorage.getItem(DB_KEYS.OFFERS)) {
            localStorage.setItem(DB_KEYS.OFFERS, JSON.stringify(DEFAULT_OFFERS));
        }
        if (!localStorage.getItem(DB_KEYS.REVIEWS)) {
            localStorage.setItem(DB_KEYS.REVIEWS, JSON.stringify(DEFAULT_REVIEWS));
        }
        if (!localStorage.getItem(DB_KEYS.ORDERS)) {
            localStorage.setItem(DB_KEYS.ORDERS, JSON.stringify(DEFAULT_ORDERS));
        }
        if (!localStorage.getItem(DB_KEYS.CART)) {
            localStorage.setItem(DB_KEYS.CART, JSON.stringify([]));
        }
        if (!localStorage.getItem(DB_KEYS.WISHLIST)) {
            localStorage.setItem(DB_KEYS.WISHLIST, JSON.stringify([]));
        }
        if (!localStorage.getItem(DB_KEYS.SALES)) {
            // Generate sales ledger from initial orders
            const sales = DEFAULT_ORDERS.map(o => ({
                id: 'SALE-' + o.id,
                orderId: o.id,
                customerName: o.customerName,
                amount: o.total,
                date: o.date,
                itemCount: o.items.length
            }));
            localStorage.setItem(DB_KEYS.SALES, JSON.stringify(sales));
        }
        if (!localStorage.getItem(DB_KEYS.PAYMENTS)) {
            const payments = DEFAULT_ORDERS.map(o => ({
                id: 'PAY-' + o.id,
                orderId: o.id,
                customerName: o.customerName,
                amount: o.total,
                method: o.paymentMethod,
                status: o.paymentStatus,
                date: o.date
            }));
            localStorage.setItem(DB_KEYS.PAYMENTS, JSON.stringify(payments));
        }
    }

    get(key) {
        try {
            return JSON.parse(localStorage.getItem(key)) || [];
        } catch(e) {
            return [];
        }
    }

    set(key, data) {
        localStorage.setItem(key, JSON.stringify(data));
    }

    // --- Settings ---
    getSettings() {
        return JSON.parse(localStorage.getItem(DB_KEYS.SETTINGS)) || DEFAULT_SETTINGS;
    }
    saveSettings(settings) {
        localStorage.setItem(DB_KEYS.SETTINGS, JSON.stringify(settings));
    }

    // --- Products ---
    getProducts() { return this.get(DB_KEYS.PRODUCTS); }
    getProductById(id) { return this.getProducts().find(p => p.id === id); }
    saveProduct(product) {
        const products = this.getProducts();
        const index = products.findIndex(p => p.id === product.id);
        if (index > -1) {
            products[index] = product;
        } else {
            products.unshift(product);
        }
        this.set(DB_KEYS.PRODUCTS, products);
    }
    deleteProduct(id) {
        let products = this.getProducts();
        products = products.filter(p => p.id !== id);
        this.set(DB_KEYS.PRODUCTS, products);
    }

    // --- Categories ---
    getCategories() { return this.get(DB_KEYS.CATEGORIES); }
    saveCategory(cat) {
        const categories = this.getCategories();
        const index = categories.findIndex(c => c.id === cat.id);
        if (index > -1) {
            categories[index] = cat;
        } else {
            categories.push(cat);
        }
        this.set(DB_KEYS.CATEGORIES, categories);
    }
    deleteCategory(id) {
        let categories = this.getCategories();
        categories = categories.filter(c => c.id !== id);
        this.set(DB_KEYS.CATEGORIES, categories);
    }

    // --- Cart ---
    getCart() { return this.get(DB_KEYS.CART); }
    addToCart(productId, quantity = 1) {
        const cart = this.getCart();
        const product = this.getProductById(productId);
        if (!product) return false;

        const existingIndex = cart.findIndex(item => item.productId === productId);
        if (existingIndex > -1) {
            cart[existingIndex].quantity += quantity;
        } else {
            cart.push({
                productId: product.id,
                name: product.name,
                price: product.discount ? product.price * (1 - product.discount/100) : product.price,
                originalPrice: product.price,
                image: product.image,
                category: product.category,
                quantity: quantity
            });
        }
        this.set(DB_KEYS.CART, cart);
        return true;
    }
    updateCartQuantity(productId, quantity) {
        let cart = this.getCart();
        if (quantity <= 0) {
            cart = cart.filter(item => item.productId !== productId);
        } else {
            const item = cart.find(i => i.productId === productId);
            if (item) item.quantity = quantity;
        }
        this.set(DB_KEYS.CART, cart);
    }
    removeFromCart(productId) {
        let cart = this.getCart();
        cart = cart.filter(item => item.productId !== productId);
        this.set(DB_KEYS.CART, cart);
    }
    clearCart() {
        this.set(DB_KEYS.CART, []);
    }

    // --- Wishlist ---
    getWishlist() { return this.get(DB_KEYS.WISHLIST); }
    toggleWishlist(productId) {
        let wishlist = this.getWishlist();
        const index = wishlist.indexOf(productId);
        let added = false;
        if (index > -1) {
            wishlist.splice(index, 1);
        } else {
            wishlist.push(productId);
            added = true;
        }
        this.set(DB_KEYS.WISHLIST, wishlist);
        return added;
    }
    isInWishlist(productId) {
        return this.getWishlist().includes(productId);
    }

    // --- Users / Auth ---
    getUsers() { return this.get(DB_KEYS.USERS); }
    getCurrentUser() {
        return JSON.parse(localStorage.getItem(DB_KEYS.CURRENT_USER)) || null;
    }
    registerUser(userData) {
        const users = this.getUsers();
        if (users.some(u => u.email === userData.email)) {
            return { success: false, message: 'Email is already registered' };
        }
        const newUser = {
            id: 'user-' + Date.now(),
            name: userData.name,
            email: userData.email,
            phone: userData.phone || '',
            password: userData.password,
            address: userData.address || '',
            city: userData.city || '',
            state: userData.state || '',
            pincode: userData.pincode || '',
            ordersCount: 0,
            totalSpent: 0,
            status: 'Active'
        };
        users.push(newUser);
        this.set(DB_KEYS.USERS, users);
        return { success: true, user: newUser };
    }
    loginUser(email, password) {
        const users = this.getUsers();
        const user = users.find(u => u.email === email && u.password === password);
        if (user) {
            localStorage.setItem(DB_KEYS.CURRENT_USER, JSON.stringify(user));
            return { success: true, user };
        }
        return { success: false, message: 'Invalid email or password' };
    }
    logoutUser() {
        localStorage.removeItem(DB_KEYS.CURRENT_USER);
    }
    updateProfile(updatedData) {
        let currentUser = this.getCurrentUser();
        if (!currentUser) return false;
        
        currentUser = { ...currentUser, ...updatedData };
        localStorage.setItem(DB_KEYS.CURRENT_USER, JSON.stringify(currentUser));
        
        // Also update in users list
        const users = this.getUsers();
        const idx = users.findIndex(u => u.id === currentUser.id);
        if (idx > -1) {
            users[idx] = currentUser;
            this.set(DB_KEYS.USERS, users);
        }
        return true;
    }

    // --- Admin Auth ---
    getAdminSession() {
        return JSON.parse(localStorage.getItem(DB_KEYS.ADMIN_SESSION)) || null;
    }
    loginAdmin(email, password) {
        if (email === 'admin@furnishop.com' && password === 'admin123') {
            const admin = { name: 'Admin Manager', email: email, role: 'Super Admin' };
            localStorage.setItem(DB_KEYS.ADMIN_SESSION, JSON.stringify(admin));
            return { success: true, admin };
        }
        return { success: false, message: 'Invalid Admin Credentials' };
    }
    logoutAdmin() {
        localStorage.removeItem(DB_KEYS.ADMIN_SESSION);
    }

    // --- Orders, Inventory & Sales ---
    getOrders() { return this.get(DB_KEYS.ORDERS); }
    createOrder(orderDetails) {
        const orders = this.getOrders();
        const products = this.getProducts();
        
        // 1. Generate Order ID
        const orderId = 'ORD-' + Math.floor(1000 + Math.random() * 9000);
        
        const newOrder = {
            id: orderId,
            customerId: orderDetails.customerId || 'guest',
            customerName: orderDetails.name,
            customerEmail: orderDetails.email,
            customerPhone: orderDetails.phone,
            shippingAddress: `${orderDetails.address}, ${orderDetails.city}, ${orderDetails.state} ${orderDetails.pincode}`,
            items: orderDetails.items,
            subtotal: orderDetails.subtotal,
            tax: orderDetails.tax,
            delivery: orderDetails.delivery,
            total: orderDetails.total,
            paymentMethod: orderDetails.paymentMethod,
            paymentStatus: orderDetails.paymentMethod === 'Cash on Delivery' ? 'Pending' : 'Paid',
            orderStatus: 'Pending',
            date: new Date().toISOString().split('T')[0]
        };

        orders.unshift(newOrder);
        this.set(DB_KEYS.ORDERS, orders);

        // 2. Reduce Stock in Inventory / Products
        orderDetails.items.forEach(item => {
            const p = products.find(prod => prod.id === item.productId);
            if (p) {
                p.stock = Math.max(0, p.stock - item.quantity);
            }
        });
        this.set(DB_KEYS.PRODUCTS, products);

        // 3. Log Sales Record
        const sales = this.get(DB_KEYS.SALES);
        sales.unshift({
            id: 'SALE-' + orderId,
            orderId: orderId,
            customerName: orderDetails.name,
            amount: orderDetails.total,
            date: newOrder.date,
            itemCount: orderDetails.items.length
        });
        this.set(DB_KEYS.SALES, sales);

        // 4. Log Payment Record
        const payments = this.get(DB_KEYS.PAYMENTS);
        payments.unshift({
            id: 'PAY-' + orderId,
            orderId: orderId,
            customerName: orderDetails.name,
            amount: orderDetails.total,
            method: orderDetails.paymentMethod,
            status: newOrder.paymentStatus,
            date: newOrder.date
        });
        this.set(DB_KEYS.PAYMENTS, payments);

        // 5. Update user total spent if logged in
        if (orderDetails.customerId) {
            const users = this.getUsers();
            const u = users.find(usr => usr.id === orderDetails.customerId);
            if (u) {
                u.ordersCount = (u.ordersCount || 0) + 1;
                u.totalSpent = (u.totalSpent || 0) + orderDetails.total;
                this.set(DB_KEYS.USERS, users);
            }
        }

        // Clear cart
        this.clearCart();

        return newOrder;
    }

    updateOrderStatus(orderId, newStatus) {
        const orders = this.getOrders();
        const order = orders.find(o => o.id === orderId);
        if (order) {
            order.orderStatus = newStatus;
            this.set(DB_KEYS.ORDERS, orders);
            return true;
        }
        return false;
    }

    // --- Reviews ---
    getReviews() { return this.get(DB_KEYS.REVIEWS); }
    addReview(reviewData) {
        const reviews = this.getReviews();
        const newReview = {
            id: 'rev-' + Date.now(),
            productId: reviewData.productId,
            customerName: reviewData.customerName,
            rating: parseInt(reviewData.rating),
            comment: reviewData.comment,
            date: new Date().toISOString().split('T')[0],
            status: 'Approved' // Auto approve or Pending based on settings
        };
        reviews.unshift(newReview);
        this.set(DB_KEYS.REVIEWS, reviews);
        return newReview;
    }
    updateReviewStatus(id, status) {
        const reviews = this.getReviews();
        const r = reviews.find(rev => rev.id === id);
        if (r) {
            r.status = status;
            this.set(DB_KEYS.REVIEWS, reviews);
        }
    }
    deleteReview(id) {
        let reviews = this.getReviews();
        reviews = reviews.filter(rev => rev.id !== id);
        this.set(DB_KEYS.REVIEWS, reviews);
    }

    // --- Offers ---
    getOffers() { return this.get(DB_KEYS.OFFERS); }
    saveOffer(offer) {
        const offers = this.getOffers();
        const idx = offers.findIndex(o => o.id === offer.id);
        if (idx > -1) {
            offers[idx] = offer;
        } else {
            offers.unshift(offer);
        }
        this.set(DB_KEYS.OFFERS, offers);
    }
    deleteOffer(id) {
        let offers = this.getOffers();
        offers = offers.filter(o => o.id !== id);
        this.set(DB_KEYS.OFFERS, offers);
    }

    // --- Suppliers ---
    getSuppliers() { return this.get(DB_KEYS.SUPPLIERS); }
    saveSupplier(supplier) {
        const suppliers = this.getSuppliers();
        const idx = suppliers.findIndex(s => s.id === supplier.id);
        if (idx > -1) {
            suppliers[idx] = supplier;
        } else {
            suppliers.push(supplier);
        }
        this.set(DB_KEYS.SUPPLIERS, suppliers);
    }
    deleteSupplier(id) {
        let suppliers = this.getSuppliers();
        suppliers = suppliers.filter(s => s.id !== id);
        this.set(DB_KEYS.SUPPLIERS, suppliers);
    }
}

// Global Singleton Database Instance
const db = new FurniDB();
