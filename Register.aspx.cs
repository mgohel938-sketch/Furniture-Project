using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FurniShop
{
    public partial class Register : System.Web.UI.Page
    {
        protected Label lblMessage;
        protected TextBox txtFullName;
        protected TextBox txtEmail;
        protected TextBox txtPhone;
        protected TextBox txtPassword;
        protected TextBox txtConfirmPassword;
        protected Button btnRegister;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please fill in all required fields.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (password != confirmPass)
            {
                lblMessage.Text = "Passwords do not match!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["FurniShopConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                lblMessage.Text = "Database connection string 'FurniShopConnection' is missing in Web.config.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Users (Name, Email, Phone, Password, CreatedDate)
                                    VALUES (@Name, @Email, @Phone, @Password, @CreatedDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", fullName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Account created successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Sync with client-side localStorage db so front-end login works seamlessly
                string script = $"if (typeof db !== 'undefined') {{ db.registerUser({{ name: '{fullName}', email: '{email}', phone: '{phone}', password: '{password}' }}); }} setTimeout(function() {{ window.location.href = 'Login.aspx'; }}, 1200);";
                ClientScript.RegisterStartupScript(this.GetType(), "RegisterSuccess", script, true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Database Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}