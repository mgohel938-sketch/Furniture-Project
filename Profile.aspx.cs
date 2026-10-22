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
    public partial class Profile : System.Web.UI.Page
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
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fetchProfile();
            }
        }

        void fetchProfile()
        {
            getcon();
            string user = Session["user"].ToString();
            da = new SqlDataAdapter("select * from Users where Email='" + user + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                lblProfileName.Text = r["Name"].ToString();
                lblProfileEmail.Text = r["Email"].ToString();
                txtName.Text = r["Name"].ToString();
                txtEmail.Text = r["Email"].ToString();
                txtPhone.Text = r["Phone"].ToString();
                txtPassword.Text = r["Password"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            getcon();
            string user = Session["user"].ToString();
            cmd = new SqlCommand("update Users set Name='" + txtName.Text + "', Phone='" + txtPhone.Text + "', Password='" + txtPassword.Text + "' where Email='" + user + "'", con);
            cmd.ExecuteNonQuery();

            lblProfileName.Text = txtName.Text;
            lblMsg.Text = "Profile updated successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
