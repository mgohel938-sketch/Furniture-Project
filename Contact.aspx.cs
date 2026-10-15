using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace FurniShop
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static bool SaveContactToDB(string name, string email, string subject, string message)
        {
            string cs = ConfigurationManager.ConnectionStrings["FurniShopConnection"]?.ConnectionString;
            if (string.IsNullOrEmpty(cs)) return false;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Contact (Name, Email, Subject, Message, SubmittedDate)
                                    VALUES (@Name, @Email, @Subject, @Message, @SubmittedDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name ?? "");
                        cmd.Parameters.AddWithValue("@Email", email ?? "");
                        cmd.Parameters.AddWithValue("@Subject", subject ?? "");
                        cmd.Parameters.AddWithValue("@Message", message ?? "");
                        cmd.Parameters.AddWithValue("@SubmittedDate", DateTime.Now);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error saving contact: " + ex.Message);
                return false;
            }
        }
    }
}
