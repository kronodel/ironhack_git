import pandas as pd
import streamlit as st
from sklearn import datasets
import plotly.express as px
import matplotlib.pyplot as plt

# Load Breast Cancer dataset from Scikit-learn as a pandas DataFrame
breast_cancer = datasets.load_breast_cancer(as_frame=True)
breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)
breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

# Set page layout as wide
st.set_page_config(layout="wide")

# Add heading for the dashboard
st.markdown("# Breast Cancer Stats")

# Create two dropdowns for scatter chart
x_measurements = st.sidebar.selectbox("Select X-axis measurement", breast_cancer_df.columns[:-1])
y_measurements = st.sidebar.selectbox("Select Y-axis measurement", breast_cancer_df.columns[:-1])

# Create scatter chart
scatter_fig = px.scatter(breast_cancer_df, x=x_measurements, y=y_measurements, color="target", width=600, height=500)
st.plotly_chart(scatter_fig)

# Create multi-select for bar chart
bar_measurements = st.sidebar.multiselect("Select measurements for bar chart", breast_cancer_df.columns[:-1])

# Create bar chart
if bar_measurements:
    bar_df = breast_cancer_df.groupby("target")[bar_measurements].mean().reset_index()
    bar_fig = px.bar(bar_df, x="target", y=bar_measurements, width=600, height=500)
    st.plotly_chart(bar_fig)

# Create multi-select and radio buttons for histogram
hist_measurements = st.sidebar.multiselect("Select measurements for histogram", breast_cancer_df.columns[:-1])
hist_bins = st.sidebar.radio("Select number of bins", options=[10, 20, 30])

# Create histogram(s)
if hist_measurements:
    for measurement in hist_measurements:
        hist_fig = px.histogram(breast_cancer_df, x=measurement, color="target", nbins=hist_bins, width=600, height=500)
        st.plotly_chart(hist_fig)

# Create two dropdowns for hexbin chart
hex_x_measurements = st.sidebar.selectbox("Select X-axis measurement for hexbin chart", breast_cancer_df.columns[:-1])
hex_y_measurements = st.sidebar.selectbox("Select Y-axis measurement for hexbin chart", breast_cancer_df.columns[:-1])

# Create hexbin chart
hexbin_fig = px.density_heatmap(breast_cancer_df, x=hex_x_measurements, y=hex_y_measurements, color_continuous_scale="Viridis", nbinsx=20, nbinsy=20, width=600, height=500)
st.plotly_chart(hexbin_fig)

# Create layout using container
col1, col2 = st.columns(2) 

with col1:
    st.plotly_chart(scatter_fig)
    if bar_measurements:
        st.plotly_chart(bar_fig)

with col2:
    if hist_measurements:
        for measurement in hist_measurements:
            hist_fig = px.histogram(breast_cancer_df, x=measurement, color="target", nbins=hist_bins, width=600, height=500)
            st.plotly_chart(hist_fig)
    st.plotly_chart(hexbin_fig)

"""

# Add scatter chart widgets in sidebar
st.sidebar.markdown("## Scatter Plot")

# Create dropdowns for selecting measurements
x_variable = st.sidebar.selectbox("Select X Variable", breast_cancer.feature_names)
y_variable = st.sidebar.selectbox("Select Y Variable", breast_cancer.feature_names, index=1)

# Get selected values from dropdowns
if x_variable and y_variable:
    # Create scatter plot using selected values
    scatter_fig, ax = plt.subplots()
    ax.scatter(breast_cancer.data[:, breast_cancer.feature_names == x_variable],
               breast_cancer.data[:, breast_cancer.feature_names == y_variable],
               c=breast_cancer.target, cmap="viridis")
    ax.set_xlabel(x_variable)
    ax.set_ylabel(y_variable)
else:
    # If values are not selected, show a message
    st.write("Please select values for X and Y variables to plot a scatter chart.")
"""