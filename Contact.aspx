<%@ Page Title="FurniShop - Contact Us" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="FurniShop.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Connect With FurniShop</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Contact</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; margin-bottom: 6rem;">
                
                <!-- Contact Info & Showrooms -->
                <div>
                    <span class="section-subtitle">Private Concierge</span>
                    <h2 class="section-title" style="text-align:left; margin-bottom: 1.5rem;">Visit Our Flagship Galleries</h2>
                    <p style="color: var(--clr-text-muted); font-size: 1.05rem; line-height: 1.8; margin-bottom: 2.5rem;">
                        Our concierges are available 7 days a week to answer inquiries regarding luxury orders, custom upholstery samples, or architectural floorplans.
                    </p>

                    <div style="display: flex; flex-direction: column; gap: 2rem;">
                        <div style="display: flex; gap: 1.25rem;">
                            <div style="width: 50px; height: 50px; border-radius: 50%; background: var(--clr-accent-light); color: var(--clr-accent); display:flex; align-items:center; justify-content:center; font-size: 1.25rem;">
                                <i class="fa-solid fa-location-dot"></i>
                            </div>
                            <div>
                                <h4 style="font-size: 1.1rem; font-family: var(--font-body); font-weight:700;">New York Flagship Gallery</h4>
                                <p style="color: var(--clr-text-muted); font-size:0.9rem;">450 Madison Avenue, 12th Floor, New York, NY 10022</p>
                            </div>
                        </div>

                        <div style="display: flex; gap: 1.25rem;">
                            <div style="width: 50px; height: 50px; border-radius: 50%; background: var(--clr-accent-light); color: var(--clr-accent); display:flex; align-items:center; justify-content:center; font-size: 1.25rem;">
                                <i class="fa-solid fa-phone"></i>
                            </div>
                            <div>
                                <h4 style="font-size: 1.1rem; font-family: var(--font-body); font-weight:700;">Direct Phone & WhatsApp</h4>
                                <p style="color: var(--clr-text-muted); font-size:0.9rem;">+1 (800) 458-7647 / +1 (212) 555-0199</p>
                            </div>
                        </div>

                        <div style="display: flex; gap: 1.25rem;">
                            <div style="width: 50px; height: 50px; border-radius: 50%; background: var(--clr-accent-light); color: var(--clr-accent); display:flex; align-items:center; justify-content:center; font-size: 1.25rem;">
                                <i class="fa-solid fa-clock"></i>
                            </div>
                            <div>
                                <h4 style="font-size: 1.1rem; font-family: var(--font-body); font-weight:700;">Gallery Hours</h4>
                                <p style="color: var(--clr-text-muted); font-size:0.9rem;">Mon - Sat: 10:00 AM - 7:00 PM | Sun: 11:00 AM - 5:00 PM</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Form -->
                <div style="background: var(--clr-bg-card); padding: 2.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm);">
                    <h3 style="font-size: 1.5rem; margin-bottom: 1.5rem;">Send Us a Message</h3>
                    <div id="contact-form">
                        <div class="form-group">
                            <label class="form-label">Your Name</label>
                            <input type="text" id="cnt-name" class="form-control" required placeholder="e.g. Victoria Sterling">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <input type="email" id="cnt-email" class="form-control" required placeholder="victoria@example.com">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Subject</label>
                            <input type="text" id="cnt-subject" class="form-control" required placeholder="e.g. Inquiries regarding Velvet Sofa customization">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Message</label>
                            <textarea id="cnt-msg" class="form-control" rows="5" required placeholder="How can our design concierge assist you?"></textarea>
                        </div>
                        <button type="button" onclick="submitContactForm()" class="btn btn-primary" style="width:100%;">Send Message <i class="fa-solid fa-paper-plane"></i></button>
                    </div>
                </div>

            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function submitContactForm() {
            const name = document.getElementById('cnt-name').value.trim();
            const email = document.getElementById('cnt-email').value.trim();
            const subject = document.getElementById('cnt-subject').value.trim();
            const message = document.getElementById('cnt-msg').value.trim();

            if (!name || !email || !subject || !message) {
                showToast('Please fill out all fields', 'error');
                return;
            }

            // Save inquiry into SQL Server Database (dbo.Contact)
            fetch('Contact.aspx/SaveContactToDB', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({ name: name, email: email, subject: subject, message: message })
            });

            showToast('Thank you! Message sent to FurniShop Concierge.', 'success');
            document.getElementById('cnt-name').value = '';
            document.getElementById('cnt-email').value = '';
            document.getElementById('cnt-subject').value = '';
            document.getElementById('cnt-msg').value = '';
        }
    </script>
</asp:Content>
