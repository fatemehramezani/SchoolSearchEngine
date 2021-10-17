<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PagingControl.ascx.cs" Inherits="UserControl_Common_Other_PagingControl" %>

<div>
    <style type="text/css">
        /*td{color:#5f0}*/
        .text {
            color: #74aacc;
        }

        .fl {
            float: left;
        }

        .f2 {
            float: right;
            padding-right: 50px;
        }

        .pager {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .pager a{
            font-family:'B Mitra',"B Mitra" !important;
        }
        .page-numbers {
            border: 1px solid #CCC;
            color: #808185;
            display: block;
            float: left;
            font-size: 130%;
            margin-right: 3px;
            padding: 4px 4px 3px;
            text-decoration: none;
        }

            .page-numbers.current {
                background-color: #808185;
                border: 1px solid #808185;
                color: #fff;
                font-weight: 700;
            }

            .page-numbers.next, .page-numbers.prev {
                border: 1px solid #fff;
            }

            .page-numbers.desc {
                border: none;
                margin-bottom: 10px;
            }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=A1.ClientID %>').click(function () {
                                $('#<%=hdSize.ClientID %>').val('10');
                                Loadpage();
                            });
                            $('#<%=A2.ClientID %>').click(function () {
                                $('#<%=hdSize.ClientID %>').val('15');
                                Loadpage();
                            });
                        });
                        function Loadpage() {
                            try {
                                //reload page using new page size
                                var url = $(location).attr('href');
                                var Page = "Page=1";
                                if (url.indexOf('Page') > 0) {
                                    Page = url.split('?')[1];
                                    Page = Page.split('&')[0];
                                }
                                url = url.split('?')[0] + "?" + Page + "&Size=" + $('#<%=hdSize.ClientID %>').val() + "";
                                window.location.href = url;
                            } catch (e) {
                                alert(e);
                            }
                        }
    </script>
    <input type="hidden" runat="server" id="hdSize" />
    <div class="pagination pagination-lg pager fl">
        <asp:Label runat="server" ID="lblpre"></asp:Label>
        <asp:Label runat="server" ID="lblIst" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="spDot1" CssClass="page-numbers prev" Visible="false" Text="..."></asp:Label>
        <asp:PlaceHolder ID="pl" runat="server"></asp:PlaceHolder>
        <asp:Label runat="server" ID="spDot2" Visible="false" CssClass="page-numbers prev" Text="..."></asp:Label>
        <asp:Label runat="server" ID="lblLast" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="lblnext"></asp:Label>
    </div>
    <div class="pagination pagination-lg pager f2 bbcnasim" style="display: none;">
        <a id="A1" href="javascript:void(0);" runat="server" class="page-numbers">10</a>&nbsp;
        <a href="javascript:void(0);" id="A2" runat="server" class="page-numbers">15</a>
        <span class="page-numbers desc">نمایش صفحه</span>
    </div>
</div>
