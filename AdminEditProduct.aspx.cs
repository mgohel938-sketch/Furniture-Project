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
    public partial class AdminEditProduct : System.Web.UI.Page
    {

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
                if (Request.QueryString["id"] != null)
                {
                    ViewState["id"] = Request.QueryString["id"].ToString();
                    filldata();
                }
            }
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Products where Id='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                txtProductName.Text = r["ProductName"].ToString();
                ddlCategory.SelectedValue = r["Category"].ToString();
                txtPrice.Text = r["Price"].ToString();
                txtStock.Text = r["Stock"].ToString();
                txtDescription.Text = r["Description"].ToString();
                txtImageUrl.Text = r["ImageUrl"].ToString();
                imgPreview.ImageUrl = r["ImageUrl"].ToString();
            }
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Products set ProductName='" + txtProductName.Text + "', Category='" + ddlCategory.SelectedValue + "', Price='" + txtPrice.Text + "', Stock='" + txtStock.Text + "', Description='" + txtDescription.Text + "', ImageUrl='" + txtImageUrl.Text + "' where Id='" + ViewState["id"] + "'", con);
            cmd.ExecuteNonQuery();
            Response.Redirect("AdminProducts.aspx");
        }
    }
}
