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
    public partial class Contact : System.Web.UI.Page
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
        }

        void clear()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Contact(Name,Email,Subject,Message,SubmittedDate) values('" + txtName.Text + "', '" + txtEmail.Text + "', '" + txtSubject.Text + "', '" + txtMessage.Text + "', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "')", con);
            cmd.ExecuteNonQuery();
            clear();
            lblMsg.Text = "Thank you! Your message has been sent successfully.";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }
    }
}
