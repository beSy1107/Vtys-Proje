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
    public partial class Add_Movie : Form
    {
        NpgsqlConnection connection = new NpgsqlConnection("server=localHost; port=5432; database=vtys_proje; user Id=postgres; password=M.ctn2205;");
        public Add_Movie()
        {
            InitializeComponent();
        }

        private void Add_Movie_Load(object sender, EventArgs e)
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
        
        bool isThere;
        int userid;
     
        private void button1_Click(object sender, EventArgs e)
        {
            
            //control
            connection.Open();
            NpgsqlCommand control = new NpgsqlCommand("select moviename from movies", connection);
            NpgsqlDataReader reader2 = control.ExecuteReader();
            while (reader2.Read())
            {
                if (textBox1.Text == reader2["moviename"].ToString())
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
                string useridd;
                int catid;
                connection.Open();
                //userid bulma
                NpgsqlCommand finduserid = new NpgsqlCommand("select userid from users where username ='" + Login.saveusername + "'", connection);
                NpgsqlDataReader reader = finduserid.ExecuteReader();

                if (reader.Read())
                {
                     useridd= reader["userid"].ToString();
                    Int32.TryParse(useridd, out userid);
                    connection.Close();
                }
                else { MessageBox.Show("Userid cannot found."); }

                


                string catidd = comboBox1.SelectedValue.ToString();
                Int32.TryParse(catidd, out catid);
                if (textBox1.Text != "" && richTextBox1.Text != "")
                {
                    connection.Open();
                    NpgsqlCommand addmovie = new NpgsqlCommand("call addnewmovie(@name,@content,@catid,@userid)", connection);
                    addmovie.Parameters.AddWithValue("@name", textBox1.Text);
                    addmovie.Parameters.AddWithValue("@content", richTextBox1.Text);
                    addmovie.Parameters.AddWithValue("@catid", catid);
                    addmovie.Parameters.AddWithValue("@userid", userid);
                    addmovie.ExecuteNonQuery();
                    connection.Close();
                    MessageBox.Show("Successful!");
                    isThere = false;
                }
                else { MessageBox.Show("Topic or name is empty.", "Error"); }
            }
            else
            {
                MessageBox.Show("This movie was already added.");
            }
        }
    }
}
