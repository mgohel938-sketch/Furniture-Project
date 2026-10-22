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
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

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

        void clear()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            getcon();
            cmd = new SqlCommand("insert into Users(Name,Email,Phone,Password,CreatedDate) values('" + txtFullName.Text.Trim() + "', '" + txtEmail.Text.Trim() + "', '" + txtPhone.Text.Trim() + "', '" + txtPassword.Text + "', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')", con);
            cmd.ExecuteNonQuery();
            clear();
            Response.Redirect("Login.aspx");
        }
    }
}
