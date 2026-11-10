using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace FurniShop
{
    public class ReportHelper
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

        // Report 1: Product list (name, category, price, stock)
        public DataSet GetProductList()
        {
            getcon();
            string q = "SELECT Id, ProductName, Category, Price, Stock FROM Products ORDER BY ProductName ASC";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "ProductListReport";
            }
            con.Close();
            return ds;
        }

        // Report 2: Category-wise product report (grouped by category)
        public DataSet GetCategoryWiseProducts()
        {
            getcon();
            string q = "SELECT Category, ProductName, Price, Stock FROM Products ORDER BY Category ASC, ProductName ASC";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "CategoryWiseProductReport";
            }
            con.Close();
            return ds;
        }

        // Report 3: Low stock report (stock below limit, default 5)
        public DataSet GetLowStock(int limit)
        {
            getcon();
            string q = "SELECT Id, ProductName, Category, Price, Stock FROM Products WHERE Stock <= @limit ORDER BY Stock ASC";
            cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@limit", limit);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "LowStockReport";
            }
            con.Close();
            return ds;
        }

        // Report 4: Invoice / Bill (single bill by BillId with grand total)
        public DataSet GetInvoice(int billId)
        {
            getcon();
            string q = @"SELECT o.OrderId, o.OrderDate, o.TotalAmount, o.Status, o.PaymentMethod,
                                o.ShippingAddress, u.Name AS CustomerName, u.Email, u.Phone,
                                d.ProductName, d.Price, d.Quantity, d.Total
                         FROM Orders o
                         INNER JOIN Users u ON o.UserId = u.Id
                         LEFT JOIN OrderDetails d ON o.OrderId = d.OrderId
                         WHERE o.OrderId = @billId";
            cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@billId", billId);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "InvoiceReport";
            }
            con.Close();
            return ds;
        }

        // Report 5: Sales report (From/To date, with total amount)
        public DataSet GetSalesReport(DateTime fromDate, DateTime toDate)
        {
            getcon();
            string q = @"SELECT o.OrderId, o.OrderDate, u.Name AS CustomerName, o.PaymentMethod, o.TotalAmount, o.Status
                         FROM Orders o
                         INNER JOIN Users u ON o.UserId = u.Id
                         WHERE o.OrderDate >= @fromDate AND o.OrderDate <= @toDate
                         ORDER BY o.OrderDate DESC";
            cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@fromDate", fromDate);
            cmd.Parameters.AddWithValue("@toDate", toDate);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "SalesReport";
            }
            con.Close();
            return ds;
        }

        // Report 6: Customer-wise sales (customer name, orders count, total spent)
        public DataSet GetCustomerWiseSales()
        {
            getcon();
            string q = @"SELECT u.Id AS UserId, u.Name AS CustomerName, u.Email, u.Phone,
                                COUNT(o.OrderId) AS TotalOrders,
                                ISNULL(SUM(o.TotalAmount), 0) AS TotalSpent
                         FROM Users u
                         LEFT JOIN Orders o ON u.Id = o.UserId
                         GROUP BY u.Id, u.Name, u.Email, u.Phone
                         ORDER BY TotalSpent DESC";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "CustomerWiseSalesReport";
            }
            con.Close();
            return ds;
        }

        // Report 7: Order and delivery status report (pending, delivered, cancelled)
        public DataSet GetOrderStatusReport(string status)
        {
            getcon();
            string q = @"SELECT o.OrderId, o.OrderDate, u.Name AS CustomerName, o.TotalAmount, o.PaymentMethod, o.Status
                         FROM Orders o
                         INNER JOIN Users u ON o.UserId = u.Id";
            if (!string.IsNullOrEmpty(status) && status != "All")
            {
                q += " WHERE o.Status = @status";
            }
            q += " ORDER BY o.OrderDate DESC";

            cmd = new SqlCommand(q, con);
            if (!string.IsNullOrEmpty(status) && status != "All")
            {
                cmd.Parameters.AddWithValue("@status", status);
            }
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                ds.Tables[0].TableName = "OrderStatusReport";
            }
            con.Close();
            return ds;
        }
    }
}
