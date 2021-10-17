using DataLayer;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Text;
using System.Transactions;

namespace RepositoryLayer
{
    public static class FileStreamRepository
    {
        //File.Create(\\\\ComputerName\FileStremShareName\FileStreamDirectoryName\FileTableName\myfile.jpg)


        //private readonly string connectionString = ELearning.Resources.Properties.Resources.FileTableConnectionString;
        private static string connectionString = @"Data Source=.\SQL2014;Initial Catalog=ELearning1;Integrated Security=True;Persist Security Info=True";

        public static void Upload(int? systemObjectId, string fileName, Stream fileStream, FileType fileType, string filePath)
        {
            using (TransactionScope transactionScope = new TransactionScope())
            {
                SqlConnection sqlConnection = null;
                try
                {
                    sqlConnection = new SqlConnection(connectionString);
                    sqlConnection.Open();
                    SqlCommand sqlCommand = new SqlCommand("[File].[FileTableInsert]", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add(new SqlParameter("@systemObjectId", SqlDbType.Int));
                    sqlCommand.Parameters.Add(new SqlParameter("@fileName", SqlDbType.VarChar));
                    sqlCommand.Parameters.Add(new SqlParameter("@fileTypeId", SqlDbType.TinyInt));
                    sqlCommand.Parameters.Add(new SqlParameter("@filePath", SqlDbType.VarChar));
                    sqlCommand.Parameters.Add(new SqlParameter("@fileStream", SqlDbType.VarBinary));

                    sqlCommand.Parameters[0].Value = systemObjectId;
                    sqlCommand.Parameters[1].Value = fileName;
                    sqlCommand.Parameters[2].Value = fileType?.Id;
                    sqlCommand.Parameters[3].Value = filePath;
                    sqlCommand.Parameters[4].Value = fileStream;

                    sqlCommand.ExecuteNonQuery();
                }
                finally
                {
                    sqlConnection?.Close();
                }
                transactionScope.Complete();
            }
        }

        /*public static byte[] Download2(Guid streamId)
        {
            byte[] fileStream;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sql = "SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  SELECT TOP 1 file_stream, name, file_type, cached_file_size FROM [File].[FileTable] WHERE stream_id = @streamId";
                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.Add("@streamId", SqlDbType.UniqueIdentifier).Value = streamId;
                    connection.Open();
                    using (var sqlReader = command.ExecuteReader())
                    {
                        sqlReader.Read();
                        fileStream = (byte[])sqlReader[0];
                    }
                    connection.Close();
                    return fileStream;
                }
            }
            return null;
        }*/

        public static byte[] Download(Guid streamId)
        {
            byte[] fileStream;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                using (var sqlCommand = new SqlCommand("[File].[FileTableRead]", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add(new SqlParameter("@streamId", SqlDbType.UniqueIdentifier));
                    sqlCommand.Parameters[0].Value = streamId;
                    using (var sqlReader = sqlCommand.ExecuteReader())
                    {
                        sqlReader.Read();
                        if (!sqlReader.HasRows)
                        {
                            sqlConnection.Close();
                            return null;
                        }
                        fileStream = (byte[])sqlReader[0];
                    }
                    sqlConnection.Close();
                    return fileStream;
                }
            }
        }
    }
}
