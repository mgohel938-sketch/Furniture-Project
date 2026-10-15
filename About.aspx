<%@ Page Title="FurniShop - About Us" Language="C#" MasterPageFile="~/Customer.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="FurniShop.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="page-banner">
            <div class="container">
                <h1 class="page-title">The FurniShop Heritage</h1>
                <div class="breadcrumb">
                    <a href="Index.aspx">Home</a> / <span>About Us</span>
                </div>
            </div>
        </div>

        <div class="container" style="padding-bottom: 6rem;">
            <!-- Brand Story -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center; margin-bottom: 6rem;">
                <div>
                    <span class="section-subtitle">Est. 1998 in Milan & Copenhagen</span>
                    <h2 class="section-title" style="text-align:left; margin-bottom: 1.5rem;">Bespoke Furniture Built For Generations</h2>
                    <p style="color: var(--clr-text-muted); font-size: 1.05rem; line-height: 1.8; margin-bottom: 1.25rem;">
                        FurniShop was founded with a singular visionary pursuit: to marry Old-World European woodworking joinery with sleek, contemporary architectural design.
                    </p>
                    <p style="color: var(--clr-text-muted); font-size: 1.05rem; line-height: 1.8;">
                        Every piece in our catalog is sculpted using FSC-certified solid hardwoods, Italian aniline top-grain leathers, and hand-honed Carrara marble slabs sourced directly from historic quarries.
                    </p>
                </div>
                <div style="border-radius: var(--radius-lg); overflow: hidden; box-shadow: var(--shadow-lg);">
                    <img src="https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80" alt="Artisan Woodworking Studio">
                </div>
            </div>

            <!-- Key Statistics -->
            <div style="background: var(--clr-bg-alt); padding: 4rem 2rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); margin-bottom: 6rem;">
                <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 2rem; text-align: center;">
                    <div>
                        <div style="font-family: var(--font-heading); font-size: 3rem; font-weight: 700; color: var(--clr-accent);">25+</div>
                        <div style="font-weight: 600; color: var(--clr-text-main); margin-top: 0.5rem;">Years of Craft</div>
                    </div>
                    <div>
                        <div style="font-family: var(--font-heading); font-size: 3rem; font-weight: 700; color: var(--clr-accent);">18,000+</div>
                        <div style="font-weight: 600; color: var(--clr-text-main); margin-top: 0.5rem;">Homes Furnished</div>
                    </div>
                    <div>
                        <div style="font-family: var(--font-heading); font-size: 3rem; font-weight: 700; color: var(--clr-accent);">100%</div>
                        <div style="font-weight: 600; color: var(--clr-text-main); margin-top: 0.5rem;">Sustainable Oak</div>
                    </div>
                    <div>
                        <div style="font-family: var(--font-heading); font-size: 3rem; font-weight: 700; color: var(--clr-accent);">10 Years</div>
                        <div style="font-weight: 600; color: var(--clr-text-main); margin-top: 0.5rem;">Frame Warranty</div>
                    </div>
                </div>
            </div>

            <!-- Master Artisans -->
            <div>
                <div class="section-title-wrap">
                    <span class="section-subtitle">Leadership & Design</span>
                    <h2 class="section-title">The Creative Minds Behind FurniShop</h2>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 2rem;">
                    <div style="background: var(--clr-bg-card); padding: 1.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); text-align: center;">
                        <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80" alt="Elena Rossi" style="width: 120px; height: 120px; border-radius: 50%; margin: 0 auto 1.25rem;">
                        <h3 style="font-size: 1.25rem;">Elena Rossi</h3>
                        <span style="color: var(--clr-accent); font-weight: 600; font-size: 0.85rem;">Head of Italian Design</span>
                        <p style="color: var(--clr-text-muted); font-size: 0.9rem; margin-top: 0.75rem;">Specializes in ergonomic leather contouring and velvet upholstery frames.</p>
                    </div>
                    <div style="background: var(--clr-bg-card); padding: 1.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); text-align: center;">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80" alt="Lars Lindqvist" style="width: 120px; height: 120px; border-radius: 50%; margin: 0 auto 1.25rem;">
                        <h3 style="font-size: 1.25rem;">Lars Lindqvist</h3>
                        <span style="color: var(--clr-accent); font-weight: 600; font-size: 0.85rem;">Master Timber Architect</span>
                        <p style="color: var(--clr-text-muted); font-size: 0.9rem; margin-top: 0.75rem;">Pioneer of Scandinavian seamless joinery and sustainable forestry.</p>
                    </div>
                    <div style="background: var(--clr-bg-card); padding: 1.5rem; border-radius: var(--radius-md); border: 1px solid var(--clr-border); text-align: center;">
                        <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80" alt="Claire DuPont" style="width: 120px; height: 120px; border-radius: 50%; margin: 0 auto 1.25rem;">
                        <h3 style="font-size: 1.25rem;">Claire DuPont</h3>
                        <span style="color: var(--clr-accent); font-weight: 600; font-size: 0.85rem;">Chief Interior Concierge</span>
                        <p style="color: var(--clr-text-muted); font-size: 0.9rem; margin-top: 0.75rem;">Leads our private architectural design consultation services worldwide.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
