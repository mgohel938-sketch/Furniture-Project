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
    public partial class Cart : System.Web.UI.Page
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
            // Login check: Must be logged in to access or add to cart!
            if (Session["user"] == null)
            {
                string rawUrl = Request.RawUrl;
                Response.Redirect("Login.aspx?returnUrl=" + Server.UrlEncode(rawUrl) + "&msg=" + Server.UrlEncode("Please login first to add items to your cart."));
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["add"] != null)
                {
                    int pid = 0;
                    if (int.TryParse(Request.QueryString["add"], out pid))
                    {
                        addToCartQuick(pid);
                        Response.Redirect("Cart.aspx");
                        return;
                    }
                }

                fillCartGrid();
            }
        }

        void addToCartQuick(int pid)
        {
            getcon();
            string user = Session["user"].ToString();
            da = new SqlDataAdapter("select * from Cart_tbl where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("update Cart_tbl set qunty = qunty + 1 where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                SqlDataAdapter daProd = new SqlDataAdapter("select * from Products where Id='" + pid + "'", con);
                DataSet dsProd = new DataSet();
                daProd.Fill(dsProd);
                string price = dsProd.Tables[0].Rows.Count > 0 ? dsProd.Tables[0].Rows[0]["Price"].ToString() : "0";
                string addedDate = DateTime.Now.ToString("dd-MM-yyyy");

                cmd = new SqlCommand("insert into Cart_tbl(cart_prod_id, cart_user_id, qunty, total, addeddate) values('" + pid + "', '" + user + "', 1, '" + price + "', '" + addedDate + "')", con);
                cmd.ExecuteNonQuery();
            }
        }

        void fillCartGrid()
        {
            getcon();
            string user = Session["user"].ToString();
            da = new SqlDataAdapter("select c.cart_id, c.cart_prod_id, c.qunty, c.total, c.addeddate, p.ProductName, p.ImageUrl, p.Price from Cart_tbl c inner join Products p on c.cart_prod_id = p.Id where c.cart_user_id='" + user + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            decimal grandTotal = 0;
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                {
                    decimal p = 0;
                    int q = 0;
                    decimal.TryParse(ds.Tables[0].Rows[j]["Price"].ToString(), out p);
                    int.TryParse(ds.Tables[0].Rows[j]["qunty"].ToString(), out q);
                    grandTotal += (p * q);
                }
            }
            lblGrandTotal.Text = "&#8377;" + grandTotal.ToString("0.00");
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("delete from Cart_tbl where cart_id='" + cartId + "'", con);
            cmd.ExecuteNonQuery();
            fillCartGrid();
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            getcon();
            string user = Session["user"].ToString();
            cmd = new SqlCommand("delete from Cart_tbl where cart_user_id='" + user + "'", con);
            cmd.ExecuteNonQuery();
            fillCartGrid();
        }
    }
}
