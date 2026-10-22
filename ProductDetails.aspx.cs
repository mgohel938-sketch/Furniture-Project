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
    public partial class ProductDetails : System.Web.UI.Page
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
                string pidStr = Request.QueryString["pid"] ?? Request.QueryString["id"];
                if (!string.IsNullOrEmpty(pidStr))
                {
                    int pid = Convert.ToInt32(pidStr);
                    fetchDetails(pid);
                }
            }
        }

        void fetchDetails(int pid)
        {
            getcon();
            da = new SqlDataAdapter("select * from Products where Id='" + pid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                lblName.Text = r["ProductName"].ToString();
                lblCategory.Text = r["Category"].ToString();
                lblPrice.Text = r["Price"].ToString();
                lblDescription.Text = r["Description"].ToString();
                lblStock.Text = r["Stock"].ToString();
                imgProduct.ImageUrl = r["ImageUrl"].ToString();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string pidStr = Request.QueryString["pid"] ?? Request.QueryString["id"];
            if (!string.IsNullOrEmpty(pidStr))
            {
                int pid = Convert.ToInt32(pidStr);
                string user = Session["user"] != null ? Session["user"].ToString() : "Guest";
                int qty = 1;
                int.TryParse(txtQty.Text, out qty);
                if (qty <= 0) qty = 1;

                getcon();
                da = new SqlDataAdapter("select * from Cart_tbl where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    cmd = new SqlCommand("update Cart_tbl set qunty = qunty + " + qty + " where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    SqlDataAdapter daProd = new SqlDataAdapter("select * from Products where Id='" + pid + "'", con);
                    DataSet dsProd = new DataSet();
                    daProd.Fill(dsProd);
                    string price = dsProd.Tables[0].Rows.Count > 0 ? dsProd.Tables[0].Rows[0]["Price"].ToString() : "0";
                    string addedDate = DateTime.Now.ToString("dd-MM-yyyy");

                    cmd = new SqlCommand("insert into Cart_tbl(cart_prod_id, cart_user_id, qunty, total, addeddate) values('" + pid + "', '" + user + "', " + qty + ", '" + price + "', '" + addedDate + "')", con);
                    cmd.ExecuteNonQuery();
                }

                Response.Redirect("Cart.aspx");
            }
        }
    }
}
