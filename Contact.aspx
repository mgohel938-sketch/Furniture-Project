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
                                <h4 style="font-size: 1.1rem; font-family: var(--font-body); font-weight:700;">Flagship Gallery</h4>
                                <p style="color: var(--clr-text-muted); font-size:0.9rem;">450 Madison Avenue, 12th Floor, New York, NY 10022</p>
                            </div>
                        </div>

                        <div style="display: flex; gap: 1.25rem;">
                            <div style="width: 50px; height: 50px; border-radius: 50%; background: var(--clr-accent-light); color: var(--clr-accent); display:flex; align-items:center; justify-content:center; font-size: 1.25rem;">
                                <i class="fa-solid fa-phone"></i>
                            </div>
                            <div>
                                <h4 style="font-size: 1.1rem; font-family: var(--font-body); font-weight:700;">Direct Phone</h4>
                                <p style="color: var(--clr-text-muted); font-size:0.9rem;">+1 (800) 458-7647 / +1 (212) 555-0199</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Form -->
                <div style="background: var(--clr-bg-card); padding: 2.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm);">
                    <h3 style="font-size: 1.5rem; margin-bottom: 1.5rem;">Send Us a Message</h3>
                    <div id="contact-form">
                        <div style="margin-bottom: 1rem;">
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Your Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Victoria Sterling" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="victoria@example.com" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="e.g. Inquiries regarding customization" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" placeholder="How can our concierge assist you?" required="required"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit Message" OnClick="btnSubmit_Click" CssClass="btn btn-primary" style="width: 100%;" />
                    </div>
                </div>

            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
