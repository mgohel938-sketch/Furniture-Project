<%@ Page Title="FurniShop - Crystal Reports" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="FurniShop.Reports" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
    <style>
        .filter-panel {
            background: #ffffff;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            border: 1px solid #e0e0e0;
        }
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        .filter-label {
            font-weight: 600;
            margin-bottom: 0.35rem;
            font-size: 0.9rem;
            color: #333;
        }
        .btn-action-bar {
            display: flex;
            gap: 0.75rem;
            margin-top: 1.25rem;
            flex-wrap: wrap;
        }
        .alert-box {
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
        }
        .alert-warning {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .viewer-container {
            background: #ffffff;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            overflow-x: auto;
            min-height: 500px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="margin-bottom: 1.5rem;">
        <h2 style="font-weight: 800; margin-bottom: 0.35rem; color: #222;">
            <i class="fa-solid fa-chart-pie" style="color: var(--admin-accent, #c19a6b);"></i> Business Crystal Reports
        </h2>
        <p style="color: #666; font-size: 0.95rem;">Select from 7 XML-Schema Crystal Reports, filter parameters, and view or export directly to PDF.</p>
    </div>

    <!-- Message Panel -->
    <asp:Panel ID="pnlMessage" runat="server" Visible="false">
        <div id="divMsg" runat="server" class="alert-box">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </div>
    </asp:Panel>

    <!-- Filter & Control Panel -->
    <div class="filter-panel">
        <div class="filter-grid">
            <!-- Dropdown for Report Selection -->
            <div class="filter-group" style="grid-column: span 2;">
                <label class="filter-label">Select Report *</label>
                <asp:DropDownList ID="ddlReport" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlReport_SelectedIndexChanged">
                    <asp:ListItem Text="1. Product List (Name, Category, Price, Stock)" Value="ProductListReport"></asp:ListItem>
                    <asp:ListItem Text="2. Category-Wise Product Report" Value="CategoryWiseProductReport"></asp:ListItem>
                    <asp:ListItem Text="3. Low Stock Report (Threshold Filter)" Value="LowStockReport"></asp:ListItem>
                    <asp:ListItem Text="4. Invoice / Bill (By Bill / Order ID)" Value="InvoiceReport"></asp:ListItem>
                    <asp:ListItem Text="5. Sales Report (Date Range Filter)" Value="SalesReport"></asp:ListItem>
                    <asp:ListItem Text="6. Customer-Wise Sales Summary" Value="CustomerWiseSalesReport"></asp:ListItem>
                    <asp:ListItem Text="7. Order & Delivery Status Report" Value="OrderStatusReport"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Stock Limit Filter (Report 3) -->
            <asp:Panel ID="pnlStockLimit" runat="server" CssClass="filter-group" Visible="false">
                <label class="filter-label">Stock Limit (Max):</label>
                <asp:TextBox ID="txtStockLimit" runat="server" CssClass="form-control" Text="5" TextMode="Number"></asp:TextBox>
            </asp:Panel>

            <!-- Bill ID / Order ID Filter (Report 4) -->
            <asp:Panel ID="pnlBillId" runat="server" CssClass="filter-group" Visible="false">
                <label class="filter-label">Bill / Order ID *:</label>
                <asp:TextBox ID="txtBillId" runat="server" CssClass="form-control" placeholder="e.g. 1001" TextMode="Number"></asp:TextBox>
            </asp:Panel>

            <!-- Date Range Filters (Report 5) -->
            <asp:Panel ID="pnlFromDate" runat="server" CssClass="filter-group" Visible="false">
                <label class="filter-label">From Date:</label>
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </asp:Panel>

            <asp:Panel ID="pnlToDate" runat="server" CssClass="filter-group" Visible="false">
                <label class="filter-label">To Date:</label>
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </asp:Panel>

            <!-- Delivery Status Filter (Report 7) -->
            <asp:Panel ID="pnlStatus" runat="server" CssClass="filter-group" Visible="false">
                <label class="filter-label">Order Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="All Statuses" Value="All"></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                    <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                </asp:DropDownList>
            </asp:Panel>
        </div>

        <!-- Action Buttons -->
        <div class="btn-action-bar">
            <asp:Button ID="btnShowReport" runat="server" Text="Show Report" CssClass="btn btn-primary" OnClick="btnShowReport_Click" />
            <asp:Button ID="btnDownloadPdf" runat="server" Text="Download PDF" CssClass="btn btn-outline" OnClick="btnDownloadPdf_Click" />
            <asp:Button ID="btnGenerateSchemas" runat="server" Text="Generate All XML Schemas" CssClass="btn btn-secondary" style="margin-left: auto;" OnClick="btnGenerateSchemas_Click" />
        </div>
    </div>

    <!-- Crystal Report Viewer Container -->
    <div class="viewer-container">
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
            AutoDataBind="true" 
            ToolPanelView="None" 
            EnableDatabaseLogonPrompt="false" 
            EnableParameterPrompt="false" 
            HasToggleGroupTreeButton="false" 
            HasCrystalLogo="false" 
            Width="100%" 
            BestFitPage="true" />
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
