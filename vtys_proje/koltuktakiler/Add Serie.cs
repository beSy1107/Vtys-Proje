using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace koltuktakiler
{
    public partial class Add_Serie : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Add_Serie()
        {
            InitializeComponent();
        }

        private void Add_Serie_Load(object sender, EventArgs e)
        {
            connection.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter("select * from filmcategories", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);

            comboBox1.DisplayMember = "catname";
            comboBox1.ValueMember = "catid";

            comboBox1.DataSource = dt;
            connection.Close();
        }
        int userid;
        bool isThere;
        private void button1_Click(object sender, EventArgs e)
        {
            //control
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("select seriename from series", connection);
            NpgsqlDataReader reader2 = control.ExecuteReader();
            while (reader2.Read())
            {
                if (textBox1.Text == reader2["seriename"].ToString())
                {
                    isThere = false;
                    break;
                }
                else
                {
                    isThere = true;
                }
            }
            connection.Close();
            if (isThere == true)
            {
                connection.Open();
                //userid bulma
                NpgsqlCommand finduserid = new NpgsqlCommand("select userid from users where username ='" + Login.saveusername + "'", connection);
                NpgsqlDataReader reader = finduserid.ExecuteReader();

                if (reader.Read())
                {
                    string useridd = reader["userid"].ToString();
                    Int32.TryParse(useridd, out userid);
                    connection.Close();
                }
                else { MessageBox.Show("Userid cannot found."); }
                
                if (textBox1.Text != "" && richTextBox1.Text != "")
                {
                    

                    string catidd = comboBox1.SelectedValue.ToString();
                    int catid;
                    Int32.TryParse(catidd, out catid);
                    connection.Open();

                    NpgsqlCommand addnewserie = new NpgsqlCommand("call addnewserie('" + textBox1.Text + "','" + richTextBox1.Text + "'," + catid + "," + userid + ")", connection);
                    addnewserie.ExecuteNonQuery();
                    connection.Close();
                    MessageBox.Show("Successful!");
                    isThere = false;
                }
                else { MessageBox.Show("Topic or name is empty.","Error"); }
            }
            else
            {
                MessageBox.Show("This serie was already added.");
            }
        }
    }
    
}
