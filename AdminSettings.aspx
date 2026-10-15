<%@ Page Title="Global Settings - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminSettings.aspx.cs" Inherits="FurniShop.AdminSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card" style="max-width: 750px; margin: 0 auto;">
        <div class="admin-card-header">
            <h2>Global E-Commerce System Configurations</h2>
        </div>

        <div class="admin-card-body">
            <div id="settings-form">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                    <div class="form-group">
                        <label class="form-label">Website Name *</label>
                        <input type="text" id="set-name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Logo Text *</label>
                        <input type="text" id="set-logo" class="form-control" required>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.25rem;">
                    <div class="form-group">
                        <label class="form-label">Currency Symbol *</label>
                        <input type="text" id="set-currency" class="form-control" required placeholder="$">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tax Rate (%) *</label>
                        <input type="number" id="set-tax" class="form-control" required min="0" step="0.1">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Delivery Charge ($) *</label>
                        <input type="number" id="set-delivery" class="form-control" required min="0" step="1">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Low Stock Alert Threshold (Units) *</label>
                    <input type="number" id="set-lowstock" class="form-control" required min="1">
                </div>

                <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--admin-border); text-align: right;">
                    <button type="button" onclick="handleSettingsSave()" class="btn btn-accent btn-lg">
                        <i class="fa-solid fa-floppy-disk"></i> Save Global Configurations
                    </button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            loadCurrentSettings();
        });

        function loadCurrentSettings() {
            const settings = db.getSettings();
            document.getElementById('set-name').value = settings.websiteName || 'FurniShop Luxury';
            document.getElementById('set-logo').value = settings.logoText || 'FurniShop';
            document.getElementById('set-currency').value = settings.currency || '$';
            document.getElementById('set-tax').value = settings.taxRate || 8;
            document.getElementById('set-delivery').value = settings.deliveryCharge || 150;
            document.getElementById('set-lowstock').value = settings.lowStockLimit || 3;
        }

        function handleSettingsSave() {
            const name = document.getElementById('set-name').value;
            const logo = document.getElementById('set-logo').value;

            if (!name || !logo) {
                alert('Please fill out website name and logo text');
                return;
            }

            const newSettings = {
                websiteName: name,
                logoText: logo,
                currency: document.getElementById('set-currency').value,
                taxRate: parseFloat(document.getElementById('set-tax').value),
                deliveryCharge: parseFloat(document.getElementById('set-delivery').value),
                lowStockLimit: parseInt(document.getElementById('set-lowstock').value)
            };

            db.saveSettings(newSettings);
            alert('Settings saved successfully!\nAll customer calculations (tax, shipping, currency) and admin thresholds automatically updated.');
            loadCurrentSettings();
        }
    </script>
</asp:Content>
