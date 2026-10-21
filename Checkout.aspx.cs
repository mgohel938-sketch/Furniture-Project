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
    public partial class Checkout : System.Web.UI.Page
    {
        protected Label lblMessage;
        protected TextBox txtName;
        protected TextBox txtEmail;
        protected TextBox txtPhone;
        protected TextBox txtAddress;
        protected DropDownList ddlPayment;
        protected Label lblOrderTotal;
        protected Button btnPlaceOrder;

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
                calculateTotal();
            }
        }

        void calculateTotal()
        {
            getcon();
            string user = Session["user"] != null ? Session["user"].ToString() : "Guest";
            da = new SqlDataAdapter("select c.qunty, p.Price from Cart_tbl c inner join Products p on c.cart_prod_id = p.Id where c.cart_user_id='" + user + "'", con);
            ds = new DataSet();
            da.Fill(ds);

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

            lblOrderTotal.Text = "&#8377;" + grandTotal.ToString("0.00");
            ViewState["total"] = grandTotal;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            getcon();
            string user = Session["user"] != null ? Session["user"].ToString() : "Guest";
            decimal total = ViewState["total"] != null ? Convert.ToDecimal(ViewState["total"]) : 0;
            string now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            cmd = new SqlCommand("insert into Orders(CustomerName, CustomerEmail, Address, TotalPrice, PaymentMethod, OrderDate) values('" + txtName.Text + "', '" + txtEmail.Text + "', '" + txtAddress.Text + "', '" + total + "', '" + ddlPayment.SelectedValue + "', '" + now + "')", con);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("delete from Cart_tbl where cart_user_id='" + user + "'", con);
            cmd.ExecuteNonQuery();

            Response.Redirect("OrderConfirmation.aspx");
        }
    }
}
