<%@ Page Title="Add Product - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddProduct.aspx.cs" Inherits="FurniShop.AdminAddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Add New Furniture Item</h2>
            <a href="AdminProducts.aspx" class="btn btn-outline btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Products
            </a>
        </div>

        <div class="admin-card-body">
            <div style="margin-bottom: 1rem; text-align: center;">
                <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>
            </div>

            <div id="add-prod-form">
                <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
                    
                    <div>
                        <div class="form-group">
                            <label class="form-label">Product Name *</label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="e.g. Florence Velvet Armchair" required="required"></asp:TextBox>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                            <div class="form-group">
                                <label class="form-label">Category *</label>
                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Price (₹) *</label>
                                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" step="0.01" CssClass="form-control" placeholder="1850" required="required"></asp:TextBox>
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                            <div class="form-group">
                                <label class="form-label">Stock Quantity *</label>
                                <asp:TextBox ID="txtStock" runat="server" TextMode="Number" CssClass="form-control" placeholder="10" required="required"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Image URL *</label>
                                <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" placeholder="https://images.unsplash.com/..." required="required" onchange="updateImagePreview(this.value)"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Detailed description of the product..."></asp:TextBox>
                        </div>
                    </div>

                    <div>
                        <label class="form-label">Image Preview</label>
                        <div style="aspect-ratio: 4/3; border-radius: var(--admin-radius); overflow: hidden; background: var(--admin-bg); border: 1px dashed var(--admin-border); display: flex; align-items: center; justify-content: center;">
                            <img id="image-preview" src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=800&q=80" alt="Preview" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <p style="font-size: 0.8rem; color: var(--admin-text-muted); margin-top: 0.5rem; text-align: center;">Paste a valid image link to update live preview.</p>
                    </div>

                </div>

                <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--admin-border); text-align: right;">
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Save & Publish Product" OnClick="btnSaveProduct_Click" CausesValidation="false" CssClass="btn btn-accent btn-lg" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
    <script>
        function updateImagePreview(url) {
            if (url) document.getElementById('image-preview').src = url;
        }
    </script>
</asp:Content>
