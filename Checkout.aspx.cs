using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;

namespace FurniShop
{
    public partial class Checkout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static bool SaveOrderToDB(string customerName, string customerEmail, string address, decimal totalPrice, string paymentMethod)
        {
            string cs = ConfigurationManager.ConnectionStrings["FurniShopConnection"]?.ConnectionString;
            if (string.IsNullOrEmpty(cs)) return false;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Orders (CustomerName, CustomerEmail, Address, TotalPrice, PaymentMethod, OrderDate)
                                    VALUES (@CustomerName, @CustomerEmail, @Address, @TotalPrice, @PaymentMethod, @OrderDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CustomerName", customerName ?? "");
                        cmd.Parameters.AddWithValue("@CustomerEmail", customerEmail ?? "");
                        cmd.Parameters.AddWithValue("@Address", address ?? "");
                        cmd.Parameters.AddWithValue("@TotalPrice", totalPrice);
                        cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod ?? "");
                        cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error saving order to DB: " + ex.Message);
                return false;
            }
        }
    }
}
