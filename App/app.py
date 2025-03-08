import streamlit as st
import psycopg2
import pandas as pd

# Database connection
def create_connection():
    return psycopg2.connect(
        host="localhost",  
        database="GlobalSuperStore",  
        user="postgres", 
        password="12345",  
        port="5432"
    )

# Fetch data function
def fetch_data(query):
    try:
        conn = create_connection()
        cursor = conn.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        cursor.close()
        conn.close()
        return pd.DataFrame(data, columns=columns)
    except Exception as e:
        st.error(f"Error fetching data: {e}")
        return None

# Streamlit app
def main():
    st.title("Database Query Interface")

    st.sidebar.header("Options")
    options = ["View Tables", "Run Custom Query"]
    choice = st.sidebar.radio("Choose an action", options)

    # Option 1: View Tables
    if choice == "View Tables":
        st.header("View Available Tables")
        tables = ["Address", "Market", "Customers", "Categories", "Products", "Orders", "Order_Details", "Shipping", "Sales"]
        selected_table = st.selectbox("Select a Table to View", tables)
        if st.button("Fetch Table"):
            query = f"SELECT * FROM {selected_table};"
            data = fetch_data(query)
            if data is not None:
                st.write(f"Displaying data from the `{selected_table}` table:")
                st.dataframe(data)

    # Option 2: Run Custom Query
    elif choice == "Run Custom Query":
        st.header("Run Custom SQL Query")
        query = st.text_area("Enter your SQL query below:")
        if st.button("Run Query"):
            data = fetch_data(query)
            if data is not None:
                st.write("Query Result:")
                st.dataframe(data)


# Run the Streamlit app
if __name__ == "__main__":
    main()
