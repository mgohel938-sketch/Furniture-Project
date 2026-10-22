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
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtEmail.Text)) && !(string.IsNullOrEmpty(txtPassword.Text)))
            {
                getcon();
                cmd = new SqlCommand("select count(*) from Users where (Email='" + txtEmail.Text.Trim() + "' or Name='" + txtEmail.Text.Trim() + "') and Password='" + txtPassword.Text.Trim() + "'", con);
                i = Convert.ToInt16(cmd.ExecuteScalar());
                if (i > 0)
                {
                    Session["user"] = txtEmail.Text.Trim();
                    Response.Redirect("Index.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid Email or Password. Please try again.";
                }
            }
            else
            {
                lblMessage.Text = "Please enter both Email and Password.";
            }
        }
    }
}
