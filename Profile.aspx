<%@ Page Title="FurniShop - My Account Profile" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="FurniShop.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">My Luxury Account</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Profile</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div id="profile-container">
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            renderProfilePage();
        });

        function renderProfilePage() {
            const currentUser = db.getCurrentUser();
            const container = document.getElementById('profile-container');
            if (!container) return;

            if (!currentUser) {
                container.innerHTML = `
                    <div style="text-align: center; padding: 4rem;">
                        <h2>Please Sign In To Access Your Profile</h2>
                        <a href="Login.aspx" class="btn btn-primary" style="margin-top:1rem;">Sign In Now</a>
                    </div>
                `;
                return;
            }

            container.innerHTML = `
                <div style="display: grid; grid-template-columns: 300px 1fr; gap: 3rem;">
                    <div style="background: var(--clr-bg-card); padding: 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); height: fit-content;">
                        <div style="text-align: center; margin-bottom: 2rem; padding-bottom: 1.5rem; border-bottom: 1px solid var(--clr-border);">
                            <div style="width: 80px; height: 80px; border-radius: 50%; background: var(--clr-accent); color: white; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: 700; margin: 0 auto 1rem;">
                                ${currentUser.name.charAt(0)}
                            </div>
                            <h3 style="font-size: 1.2rem;">${currentUser.name}</h3>
                            <div style="font-size: 0.85rem; color: var(--clr-text-muted);">${currentUser.email}</div>
                        </div>

                        <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                            <a href="Profile.aspx" class="btn btn-primary btn-sm" style="width:100%; justify-content: flex-start;"><i class="fa-solid fa-user-gear"></i> Account Profile</a>
                            <a href="MyOrders.aspx" class="btn btn-outline btn-sm" style="width:100%; justify-content: flex-start;"><i class="fa-solid fa-box"></i> My Orders</a>
                            <a href="Wishlist.aspx" class="btn btn-outline btn-sm" style="width:100%; justify-content: flex-start;"><i class="fa-solid fa-heart"></i> Saved Wishlist</a>
                            <button type="button" onclick="handleLogout()" class="btn btn-outline btn-sm" style="width:100%; justify-content: flex-start; color: var(--clr-danger); border-color: var(--clr-border); margin-top: 1rem;">
                                <i class="fa-solid fa-right-from-bracket"></i> Sign Out
                            </button>
                        </div>
                    </div>

                    <div style="background: var(--clr-bg-card); padding: 2.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border);">
                        <h3 style="font-size: 1.5rem; margin-bottom: 1.5rem; padding-bottom: 0.75rem; border-bottom: 1px solid var(--clr-border);">Personal Details & Address</h3>
                        
                        <div id="prof-form">
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" id="prof-name" class="form-control" required value="${currentUser.name}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Email Address (Read-only)</label>
                                    <input type="email" class="form-control" readonly value="${currentUser.email}" style="background: var(--clr-bg-alt);">
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" id="prof-phone" class="form-control" value="${currentUser.phone || ''}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Street Address</label>
                                    <input type="text" id="prof-address" class="form-control" value="${currentUser.address || ''}">
                                </div>
                            </div>

                            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.25rem;">
                                <div class="form-group">
                                    <label class="form-label">City</label>
                                    <input type="text" id="prof-city" class="form-control" value="${currentUser.city || ''}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">State</label>
                                    <input type="text" id="prof-state" class="form-control" value="${currentUser.state || ''}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Pincode</label>
                                    <input type="text" id="prof-pincode" class="form-control" value="${currentUser.pincode || ''}">
                                </div>
                            </div>

                            <button type="button" onclick="handleProfileUpdate()" class="btn btn-primary btn-lg" style="margin-top: 1rem;">Update Profile Information</button>
                        </div>
                    </div>

                </div>
            `;
        }

        function handleProfileUpdate() {
            const updated = {
                name: document.getElementById('prof-name').value,
                phone: document.getElementById('prof-phone').value,
                address: document.getElementById('prof-address').value,
                city: document.getElementById('prof-city').value,
                state: document.getElementById('prof-state').value,
                pincode: document.getElementById('prof-pincode').value
            };

            db.updateProfile(updated);
            showToast('Profile updated successfully!', 'success');
            renderHeader();
            renderProfilePage();
        }
    </script>
</asp:Content>
