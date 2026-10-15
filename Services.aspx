<%@ Page Title="FurniShop - White-Glove Services" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="FurniShop.Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">Bespoke Concierge & Services</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>Services</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <div class="section-title-wrap">
                <span class="section-subtitle">Beyond Furniture</span>
                <h2 class="section-title">End-To-End Luxury Experience</h2>
                <p>We provide full-spectrum architectural services to elevate your living spaces.</p>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 2.5rem; margin-bottom: 6rem;">
                <div style="background: var(--clr-bg-card); border-radius: var(--radius-md); padding: 2.5rem; border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm);">
                    <i class="fa-solid fa-truck-ramp-box" style="font-size: 3rem; color: var(--clr-accent); margin-bottom: 1.5rem;"></i>
                    <h3 style="font-size: 1.5rem; margin-bottom: 1rem;">White-Glove Delivery</h3>
                    <p style="color: var(--clr-text-muted); line-height: 1.7; margin-bottom: 1.5rem;">
                        Our dedicated delivery specialists transport your pieces in climate-controlled vans, carry them into your desired room, complete all assembly, and remove packing materials.
                    </p>
                    <ul style="color: var(--clr-text-muted); font-size: 0.9rem; display:flex; flex-direction:column; gap:0.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Scheduled 2-hour appointment window</li>
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Full inspection & polish before handoff</li>
                    </ul>
                </div>

                <div style="background: var(--clr-bg-card); border-radius: var(--radius-md); padding: 2.5rem; border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm);">
                    <i class="fa-solid fa-pen-ruler" style="font-size: 3rem; color: var(--clr-accent); margin-bottom: 1.5rem;"></i>
                    <h3 style="font-size: 1.5rem; margin-bottom: 1rem;">Bespoke Furniture Customization</h3>
                    <p style="color: var(--clr-text-muted); line-height: 1.7; margin-bottom: 1.5rem;">
                        Need custom dimensions or specific leather swatches? Work with our master craftsmen to tailor wood finishes, fabrics, and dimensions to fit your exact floorplan.
                    </p>
                    <ul style="color: var(--clr-text-muted); font-size: 0.9rem; display:flex; flex-direction:column; gap:0.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Over 150+ luxury fabric & leather swatches</li>
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Custom CAD floorplan rendering</li>
                    </ul>
                </div>

                <div style="background: var(--clr-bg-card); border-radius: var(--radius-md); padding: 2.5rem; border: 1px solid var(--clr-border); box-shadow: var(--shadow-sm);">
                    <i class="fa-solid fa-shield-halved" style="font-size: 3rem; color: var(--clr-accent); margin-bottom: 1.5rem;"></i>
                    <h3 style="font-size: 1.5rem; margin-bottom: 1rem;">10-Year Comprehensive Warranty</h3>
                    <p style="color: var(--clr-text-muted); line-height: 1.7; margin-bottom: 1.5rem;">
                        Rest assured knowing every solid wood frame, corner block, and reclining mechanism is safeguarded against structural manufacturing defects for a full decade.
                    </p>
                    <ul style="color: var(--clr-text-muted); font-size: 0.9rem; display:flex; flex-direction:column; gap:0.5rem;">
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Free annual frame tightening inspection</li>
                        <li><i class="fa-solid fa-check" style="color: var(--clr-accent);"></i> Complimentary wood conditioning kit</li>
                    </ul>
                </div>
            </div>

            <!-- Service Request Form -->
            <div style="background: var(--clr-bg-alt); padding: 3.5rem; border-radius: var(--radius-lg); border: 1px solid var(--clr-border); max-width: 800px; margin: 0 auto;">
                <h3 style="font-size: 1.75rem; text-align: center; margin-bottom: 0.5rem;">Book a Design Concierge Session</h3>
                <p style="text-align: center; color: var(--clr-text-muted); margin-bottom: 2rem;">Fill out the form below to request a private consultation with our senior interior architects.</p>
                <div id="service-req-form">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" id="srv-name" class="form-control" required placeholder="e.g. Julian Thorne">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" id="srv-phone" class="form-control" required placeholder="+1 (555) 000-0000">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Service Type Requested</label>
                        <select id="srv-type" class="form-control">
                            <option>White-Glove Delivery Scheduling</option>
                            <option>Custom Dimension Furniture Request</option>
                            <option>Full Interior Architectural Consultation</option>
                            <option>Warranty & Maintenance Inspection</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Project Details & Floorplan Notes</label>
                        <textarea id="srv-notes" class="form-control" rows="4" placeholder="Tell us about your room, target timeline, and aesthetic preferences..."></textarea>
                    </div>
                    <button type="button" onclick="submitServiceRequest()" class="btn btn-primary btn-lg" style="width: 100%;">Submit Concierge Request</button>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function submitServiceRequest() {
            showToast('Concierge Request Submitted! We will call you within 24h.', 'success');
            document.getElementById('srv-name').value = '';
            document.getElementById('srv-phone').value = '';
            document.getElementById('srv-notes').value = '';
        }
    </script>
</asp:Content>
