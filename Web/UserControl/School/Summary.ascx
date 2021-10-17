<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Summary.ascx.cs" Inherits="UserControl_School_Summary" %>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" href="#collapse<%#Eval("Id") %>">
                <h2><%#Eval("Name") %></h2>
            </a>
          </h4>
        </div>
        <div id="collapse<%#Eval("Id") %>" class="panel-collapse collapse">
          <div class="panel-body speed_help_body">              
              <%# Eval("Features") %>              
          </div>
            <div class="panel-footer centered">
              <a href="../../../<%# Eval("Id")%>">
                 مشاهده اطلاعات بیشتر
              </a>
            </div>
        </div>
      </div>