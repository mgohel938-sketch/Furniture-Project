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
    public partial class AdminLogin : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text == "admin@furnishop.com" && txtPassword.Text == "admin123")
            {
                Session["admin"] = txtEmail.Text;
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            if (!(string.IsNullOrEmpty(txtEmail.Text)) && !(string.IsNullOrEmpty(txtPassword.Text)))
            {
                getcon();
                cmd = new SqlCommand("select count(*) from Users where (Email='" + txtEmail.Text + "' or Name='" + txtEmail.Text + "') and Password='" + txtPassword.Text + "'", con);
                i = Convert.ToInt16(cmd.ExecuteScalar());
                if (i > 0)
                {
                    Session["admin"] = txtEmail.Text;
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Admin Email or Password";
                }
            }
            else
            {
                lblMsg.Text = "Please enter both Email and Password";
            }
        }
    }
}
