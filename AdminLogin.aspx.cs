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
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            if (string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMsg.Text = "Please enter both Email and Password";
                return;
            }

            string email = txtEmail.Text.Trim();
            string pass = txtPassword.Text.Trim();

            // Check hardcoded admin credentials
            if (email == "admin@furnishop.com" && pass == "admin123")
            {
                Session["admin"] = email;
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            // Or check database admin credentials
            try
            {
                getcon();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE (Email = @email OR Name = @email) AND Password = @pass AND Role = 'Admin'", con);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@pass", pass);

                i = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();

                if (i > 0)
                {
                    Session["admin"] = email;
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Admin Email or Password";
                }
            }
            catch
            {
                lblMsg.Text = "Invalid Admin Email or Password";
            }
        }
    }
}
