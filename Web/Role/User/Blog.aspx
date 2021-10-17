<%@ Page Title="مدیریت بلاگ" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="Admin_Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    بلاگ
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    از طریق این صفحه می توانید  بلاگ به نمایش در آمده در صفحه اصلی را مدیریت نمایید. 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">    
    <asp:MultiView runat="server" ID="BlogMultiView" ActiveViewIndex="0">
        <asp:View runat="server" ID="ShowView">
            <asp:ImageButton ID="NewImageButton" runat="server" OnClick="NewImageButton_Click" SkinID="PanelAddImageButton" />
            <asp:ImageButton ID="SearchImageButton" runat="server" OnClick="SearchImageButton_Click"
                SkinID="PanelSearchImageButton" />
            <asp:ImageButton ID="ClearImageButton" runat="server" OnClick="ClearImageButton_Click" SkinID="PanelClearImageButton" />
            <br />
            <asp:Label ID="NameLabel" runat="server" Text="عنوان مطلب:" SkinID="Caption"></asp:Label>
            <asp:TextBox ID="TitleTextBox" runat="server" SkinID="TextBox"></asp:TextBox>
            <br />
            <asp:Label ID="SizePageLabel" runat="server" Text="سایز صفحه:" SkinID="Caption"></asp:Label>
            <asp:DropDownList ID="PageSizeDropDownList" SkinID="SearchDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="5">[پیش فرض]</asp:ListItem>
                <asp:ListItem Value="5">5 رکورد</asp:ListItem>
                <asp:ListItem Value="10">10 رکورد</asp:ListItem>
                <asp:ListItem Value="15">15 رکورد</asp:ListItem>
                <asp:ListItem Value="20">20 رکورد</asp:ListItem>
                <asp:ListItem Value="25">25 رکورد</asp:ListItem>
                <asp:ListItem Value="1000000">تمام رکورد ها</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:GridView ID="BlogGridView" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Id" DataSourceID="BlogEntityDataSource" HorizontalAlign="Center"
                OnSelectedIndexChanged="BlogGridView_SelectedIndexChanged" PageSize="5" Width="90%" AllowSorting="True" AllowPaging="True">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="SelectImageButton" runat="server" CommandName="Select" SkinID="PanelSelectImageButton" />
                        </ItemTemplate>
                        <ItemStyle Width="25px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Id" Visible="False" SortExpression="Id" />
                    <asp:BoundField DataField="Title" HeaderText="عنوان مطلب">
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="EditView" runat="server">
            <asp:FormView ID="BlogFormView" runat="server" Width="90%" DataSourceID="BlogEntityDataSource"
                DataKeyNames="Id" DefaultMode="Insert" OnItemDeleted="BlogFormView_ItemDeleted"
                OnItemCommand="BlogFormView_ItemCommand">
                <EditItemTemplate>
                    <div class="row">
                        <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="256" />
                        <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="SchoolLabel" runat="server" Text="مدرسه:" SkinID="Caption"></asp:Label>                        
                        <asp:DropDownList ID="SchoolDropDownList" 
                            CssClass="form-control dropdown" 
                            SelectedValue='<%# Bind("SchoolId")%>' 
                            runat="server" 
                            DataSourceID="SchoolEntityDataSource" 
                            DataTextField="Name" 
                            DataValueField="Id" 
                            Width="90%" 
                            AppendDataBoundItems="True">
                            <asp:ListItem Value="" Selected="True">[ مدرسه خود را انتخاب کنید]</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="SchoolCustomValidator" ControlToValidate="SchoolDropDownList"
                        runat="server" ErrorMessage="مدرسه را انتخاب کنید" Text="*"
                        SetFocusOnError="true" ForeColor="Red" Display="Dynamic"
                        ValidateEmptyText="true"
                        ClientValidationFunction="SelectItem" ValidationGroup="Update"></asp:CustomValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="PictureLabel" runat="server" Text="تصویر:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="PictureFileUpload" runat="server" />
                        <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر تصویر" />
                    </div>
                    <div class="row">
                        <asp:Label ID="FileLabel" runat="server" Text="فایل:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="FileFileUpload" runat="server" />
                        <asp:CheckBox ID="FileCheckBox" runat="server" Text="تغییر فایل" />
                    </div>
                    <div class="row">
                        <asp:Label ID="DescriptionLabel" runat="server" Text="متن:" SkinID="Caption"></asp:Label>
                         <asp:CKEditor ID="DescriptionTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Description")%>'/>
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="DeleteImageButton" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="حذف" OnClientClick="if (!confirm('آيا از حذف مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="UpdateImageButton" runat="server" CommandName="Update" Text="ویرایش"
                                ValidationGroup="Update" OnClientClick="if (!confirm('آيا از اعمال تغییرات مطمئن هستيد؟')) return false;" />
                            <asp:Button ID="CancelImageButton" runat="server" CommandName="Cancel" Text="انصراف" />
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="row">
                        <asp:Label ID="TitleLabel" runat="server" Text="عنوان:" SkinID="Caption"></asp:Label>
                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' MaxLength="256" />
                        <asp:RequiredFieldValidator ID="TitleRequiredFieldValidator" runat="server" ControlToValidate="TitleTextBox"
                            Display="Dynamic" ErrorMessage="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="SchoolLabel" runat="server" Text="مدرسه:" SkinID="Caption"></asp:Label>                        
                        <asp:DropDownList ID="SchoolDropDownList" 
                            CssClass="form-control dropdown" 
                            SelectedValue='<%# Bind("SchoolId")%>' 
                            runat="server" 
                            DataSourceID="SchoolEntityDataSource" 
                            DataTextField="Name" 
                            DataValueField="Id" 
                            Width="90%" 
                            AppendDataBoundItems="True">
                            <asp:ListItem Value="" Selected="True">[ مدرسه خود را انتخاب کنید]</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="SchoolCustomValidator" ControlToValidate="SchoolDropDownList"
                            runat="server" ErrorMessage="مدرسه را انتخاب کنید" Text="*"
                            SetFocusOnError="true" ForeColor="Red" Display="Dynamic"
                            ValidateEmptyText="true"
                            ClientValidationFunction="SelectItem" ValidationGroup="Insert"></asp:CustomValidator>
                    </div>
                    <div class="row">
                        <asp:Label ID="PictureLabel" runat="server" Text="تصویر:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="PictureFileUpload" runat="server" />
                        <asp:CheckBox ID="PictureCheckBox" runat="server" Text="تغییر تصویر" />
                    </div>
                    <div class="row">
                        <asp:Label ID="FileLabel" runat="server" Text="فایل:" SkinID="Caption"></asp:Label>
                        <asp:FileUpload ID="FileFileUpload" runat="server" />
                        <asp:CheckBox ID="FileCheckBox" runat="server" Text="تغییر فایل" />
                    </div>
                    <div class="row">
                        <asp:Label ID="DescriptionLabel" runat="server" Text="متن:" SkinID="Caption"></asp:Label>
                         <asp:CKEditor ID="DescriptionTextBox"  runat="server" Width="98%" EnableViewState="false" Height="400" Text='<%# Bind("Description")%>'/>                        
                    </div>
                    <div class="row">
                        <div style="float: left; padding: 10px;">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد"
                                ValidationGroup="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="انصراف" />
                        </div>
                    </div>
                </InsertItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
    <ef:EntityDataSource ID="BlogEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" EntitySetName="Blog"
        EnableUpdate="True"
        EnableDelete="True"
        EnableInsert="True"
        OnDeleted="BlogEntityDataSource_Command"
        OnInserted="BlogEntityDataSource_Command"
        OnUpdated="BlogEntityDataSource_Command"
        OnInserting="BlogEntityDataSource_Commanding"
        OnUpdating="BlogEntityDataSource_Commanding"
        OrderBy=" it.[Id] desc" EnableFlattening="False"
        Where="(@Title is null || it.Title LIKE '%' + @Title + '%') && (@ApplicantId is null || it.ApplicantId = @ApplicantId)">
        <WhereParameters>
            <asp:ControlParameter ControlID="TitleTextBox" Name="Title" Type="String" />
            <asp:ProfileParameter PropertyName="ApplicantId" Name="ApplicantId" Type="Int32" />
        </WhereParameters>
    </ef:EntityDataSource>
    <ef:EntityDataSource ID="SchoolEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities"
        DefaultContainerName="DatabaseEntities" 
        EntitySetName="Information"
        Where="it.ApplicantId = @ApplicantId">
        <WhereParameters>
            <asp:ProfileParameter PropertyName="ApplicantId" Name="ApplicantId" Type="Int32" />
        </WhereParameters>
    </ef:EntityDataSource>
</asp:Content>


