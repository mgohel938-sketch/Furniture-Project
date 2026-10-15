using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FurniShop
{
    public partial class AdminAddProduct : System.Web.UI.Page
    {
        protected Label lblMessage;
        protected TextBox txtProductName;
        protected DropDownList ddlCategory;
        protected TextBox txtPrice;
        protected TextBox txtStock;
        protected TextBox txtDescription;
        protected TextBox txtImageUrl;
        protected Button btnSaveProduct;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate Category DropDown
                ddlCategory.Items.Clear();
                ddlCategory.Items.Add(new ListItem("Sofa", "Sofa"));
                ddlCategory.Items.Add(new ListItem("Bed", "Bed"));
                ddlCategory.Items.Add(new ListItem("Chair", "Chair"));
                ddlCategory.Items.Add(new ListItem("Table", "Table"));
                ddlCategory.Items.Add(new ListItem("Dining", "Dining"));
                ddlCategory.Items.Add(new ListItem("Wardrobe", "Wardrobe"));
                ddlCategory.Items.Add(new ListItem("Office Furniture", "Office Furniture"));
                ddlCategory.Items.Add(new ListItem("Living Room", "Living Room"));
            }
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            string name = txtProductName.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string description = txtDescription.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();

            decimal price = 0;
            int stock = 0;

            decimal.TryParse(txtPrice.Text.Trim(), out price);
            int.TryParse(txtStock.Text.Trim(), out stock);

            if (string.IsNullOrEmpty(name) || price <= 0 || string.IsNullOrEmpty(imageUrl))
            {
                lblMessage.Text = "Please fill in all required fields (Product Name, Price, Image URL).";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["FurniShopConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                lblMessage.Text = "Database connection string 'FurniShopConnection' is missing in Web.config.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Products (ProductName, Category, Price, Stock, Description, ImageUrl)
                                    VALUES (@ProductName, @Category, @Price, @Stock, @Description, @ImageUrl)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ProductName", name);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Stock", stock);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Product saved successfully into Database!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Sync with localStorage for frontend rendering
                string script = $"if (typeof db !== 'undefined') {{ db.saveProduct({{ id: 'prod-' + Date.now(), name: '{name.Replace("'", "\\'")}', category: '{category}', price: {price}, stock: {stock}, description: '{description.Replace("'", "\\'")}', image: '{imageUrl}', rating: 5.0, reviewCount: 0, isFeatured: true }}); }} setTimeout(function() {{ window.location.href = 'AdminProducts.aspx'; }}, 1200);";
                ClientScript.RegisterStartupScript(this.GetType(), "SaveProdSuccess", script, true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Database Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
