<%@ Page Title="Edit Product - FurniShop Admin" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditProduct.aspx.cs" Inherits="FurniShop.AdminEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="admin-card">
        <div class="admin-card-header">
            <h2>Edit Furniture Product Details</h2>
            <a href="AdminProducts.aspx" class="btn btn-outline btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Back to Products
            </a>
        </div>

        <div class="admin-card-body">
            <div style="margin-bottom: 1rem;">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
            </div>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
                <div>
                    <div class="form-group">
                        <label class="form-label">Product Name *</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                        <div class="form-group">
                            <label class="form-label">Category *</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Sofa" Value="Sofa"></asp:ListItem>
                                <asp:ListItem Text="Bed" Value="Bed"></asp:ListItem>
                                <asp:ListItem Text="Chair" Value="Chair"></asp:ListItem>
                                <asp:ListItem Text="Table" Value="Table"></asp:ListItem>
                                <asp:ListItem Text="Dining" Value="Dining"></asp:ListItem>
                                <asp:ListItem Text="Wardrobe" Value="Wardrobe"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Price (₹) *</label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.25rem;">
                        <div class="form-group">
                            <label class="form-label">Stock Quantity *</label>
                            <asp:TextBox ID="txtStock" runat="server" TextMode="Number" CssClass="form-control" required="required"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Image URL *</label>
                            <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div>
                    <label class="form-label">Current Image</label>
                    <div style="aspect-ratio: 4/3; border-radius: var(--admin-radius); overflow: hidden; background: var(--admin-bg); border: 1px solid var(--admin-border);">
                        <asp:Image ID="imgPreview" runat="server" Width="100%" Height="100%" style="object-fit:cover;" />
                    </div>
                </div>
            </div>

            <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--admin-border); text-align: right;">
                <asp:Button ID="btnUpdateProduct" runat="server" Text="Update Product Information" OnClick="btnUpdateProduct_Click" CssClass="btn btn-accent btn-lg" />
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="AdminScriptContent" runat="server">
</asp:Content>
