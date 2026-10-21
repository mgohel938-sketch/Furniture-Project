using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

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

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCategory.Items.Clear();
                ddlCategory.Items.Add(new ListItem("Sofa", "Sofa"));
                ddlCategory.Items.Add(new ListItem("Bed", "Bed"));
                ddlCategory.Items.Add(new ListItem("Chair", "Chair"));
                ddlCategory.Items.Add(new ListItem("Table", "Table"));
                ddlCategory.Items.Add(new ListItem("Dining", "Dining"));
                ddlCategory.Items.Add(new ListItem("Wardrobe", "Wardrobe"));
            }
        }

        void clear()
        {
            txtProductName.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtDescription.Text = "";
            txtImageUrl.Text = "";
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Products(ProductName, Category, Price, Stock, Description, ImageUrl) values('" + txtProductName.Text + "', '" + ddlCategory.SelectedValue + "', '" + txtPrice.Text + "', '" + txtStock.Text + "', '" + txtDescription.Text + "', '" + txtImageUrl.Text + "')", con);
            cmd.ExecuteNonQuery();
            clear();
            Response.Redirect("AdminProducts.aspx");
        }
    }
}
