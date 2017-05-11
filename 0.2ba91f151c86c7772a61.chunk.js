webpackJsonp([0],{"./app/components/Money/Money.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}function o(e){var n=arguments.length>1&&void 0!==arguments[1]?arguments[1]:",";return void 0==e?null:e.toString().replace(/\B(?=(\d{3})+(?!\d))/g,n)}function a(e){return o(e.toString().split(".")[0])}function s(e){var n=e.toString().split(".")[1],t=n?n.slice(0,2):"0";return 1==t.length?t+"0":t}var i=t("./app/components/Money/styles.js"),l=t("./node_modules/react/react.js"),d=t.n(l),u=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),c=u(i.a.Sign,{},void 0,"$"),p=function(e){var n=e.value,t=e.showCents,o=r(e,["value","showCents"]);return d.a.createElement(i.a.Wrapper,o,c,a(n),t&&u(i.a.Cents,{},void 0,".",s(n)))};p.defaultProps={showCents:!0},n.a=p},"./app/components/Money/index.js":function(e,n,t){"use strict";var r=t("./app/components/Money/Money.js");n.a=r.a},"./app/components/Money/styles.js":function(e,n,t){"use strict";function r(e,n){return Object.freeze(Object.defineProperties(e,{raw:{value:Object.freeze(n)}}))}var o=t("./node_modules/styled-components/dist/styled-components.es.js"),a=(t("./app/styles/variables.js"),r(["\n  font-size: 1.1em;\n"],["\n  font-size: 1.1em;\n"])),s=r(["\n  font-size    : 0.615em;\n  margin-right : 0.1em;\n  opacity      : 0.67;\n  top          : -0.4em;\n"],["\n  font-size    : 0.615em;\n  margin-right : 0.1em;\n  opacity      : 0.67;\n  top          : -0.4em;\n"]),i=r(["\n  font-size : 0.615em;\n  opacity   : 0.67;\n  top       : -0.4em;\n"],["\n  font-size : 0.615em;\n  opacity   : 0.67;\n  top       : -0.4em;\n"]),l=o.a.span(a),d=o.a.sup(s),u=o.a.sup(i);n.a={Wrapper:l,Sign:d,Cents:u}},"./app/components/PageWrapper/PageWrapper.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./app/components/PageWrapper/styles.js"),a=t("./node_modules/react/react.js"),s=t.n(a),i=t("./node_modules/react-helmet/lib/Helmet.js"),l=t.n(i),d=Object.assign||function(e){for(var n=1;n<arguments.length;n++){var t=arguments[n];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},u=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),c=function(e){var n=e.fill,t=e.title,a=e.loading,i=e.description,c=e.children,p=r(e,["fill","title","loading","description","children"]);return s.a.createElement(o.a.Elem,d({fill:n,loading:a},p),u(l.a,{title:t,meta:[{name:"description",content:i}]}),c)};c.defaultProps={fill:!1,loading:!1},n.a=c},"./app/components/PageWrapper/index.js":function(e,n,t){"use strict";var r=t("./app/components/PageWrapper/PageWrapper.js");n.a=r.a},"./app/components/PageWrapper/styles.js":function(e,n,t){"use strict";function r(e,n){return Object.freeze(Object.defineProperties(e,{raw:{value:Object.freeze(n)}}))}var o=t("./node_modules/styled-components/dist/styled-components.es.js"),a=t("./app/styles/variables.js"),s=r(["\n  opacity        : 1;\n  overflow-x     : hidden;\n  padding-bottom : ",";\n  padding-top    : ",";\n  transition     : ",";\n\n  ","\n\n  ","\n\n  .bounds-wrapper + .bounds-wrapper {\n    padding-top: 0;\n  }\n"],["\n  opacity        : 1;\n  overflow-x     : hidden;\n  padding-bottom : ",";\n  padding-top    : ",";\n  transition     : ",";\n\n  ","\n\n  ","\n\n  .bounds-wrapper + .bounds-wrapper {\n    padding-top: 0;\n  }\n"]),i=o.a.main(s,a.a.gutterLg,a.a.gutterLg,a.a.transition,function(e){return e.loading&&"\n    opacity        : 0.5;\n    pointer-events : none;\n  "},function(e){return e.fill&&"\n    align-content   : stretch;\n    align-items     : stretch;\n    display         : flex;\n    flex-direction  : column;\n    justify-content : flex-start;\n\n    > .bounds-wrapper {\n      flex  : 0 0 auto;\n      width : 100%;\n    }\n  "});n.a={Elem:i}},"./app/containers/OrdersTable/AddressColumn.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./node_modules/react/react.js"),a=(t.n(o),function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}()),s=a("br",{}),i=a("br",{}),l=function(e){var n=e.address,t=(r(e,["address"]),n.line1),o=n.line2,l=n.city,d=n.state,u=n.postal_code;return a("address",{},void 0,a("span",{},void 0,t,s),o&&a("span",{},void 0,o,i),a("span",{},void 0,l,", ",d," ",u))};n.a=l},"./app/containers/OrdersTable/ItemsColumn.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./app/containers/OrdersTable/styles.js"),a=t("./node_modules/react/react.js"),s=(t.n(a),t("./app/components/Money/index.js")),i=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),l=i("hr",{}),d=function(e){var n=e.items;r(e,["items"]);return i("div",{},void 0,n.map(function(e){return i(o.a.Item,{},e.type+e.parent,i("span",{},void 0,e.quantity,"x ",i("strong",{},void 0,e.parent," ")),l,i(s.a,{value:e.amount/100}))}))};d.ItemsColumn={items:a.PropTypes.array.isRequired},n.a=d},"./app/containers/OrdersTable/OrdersFooter.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./app/containers/OrdersTable/styles.js"),a=t("./node_modules/lodash/find.js"),s=t.n(a),i=t("./node_modules/lodash/reduce.js"),l=t.n(i),d=t("./node_modules/react/react.js"),u=(t.n(d),t("./app/components/Money/index.js")),c=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),p=c(o.a.Column,{width:85},"status"),f=c(o.a.Column,{width:125},"order_date"),m=c(o.a.Column,{width:125},"shipped_date"),h=c(o.a.Column,{},"customer"),y=c(o.a.Column,{},"address"),b=c(o.a.Column,{width:60,title:c("small",{},void 0,"Totals:")},"order"),v=function(e){var n=e.orders,t=(r(e,["orders"]),l()(n,function(e,n){return e+=parseInt(s()(n.items,{type:"tax"}).amount)/100},0)),a=l()(n,function(e,n){return e+=parseInt(s()(n.items,{type:"shipping"}).amount)/100},0),i=l()(n,function(e,n){return e+=parseInt(n.amount)/100},0);return c(o.a.Footer,{dataSource:[],pagination:!1},void 0,p,f,m,h,y,b,c(o.a.Column,{width:70,title:c(u.a,{value:t})},"sales_tax"),c(o.a.Column,{width:70,title:c(u.a,{value:a})},"shipping"),c(o.a.Column,{width:85,title:c(u.a,{value:i})},"total"))};n.a=v},"./app/containers/OrdersTable/OrdersTable.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./app/containers/OrdersTable/styles.js"),a=t("./app/containers/OrdersTable/ShipColumn.js"),s=t("./app/containers/OrdersTable/ItemsColumn.js"),i=t("./app/containers/OrdersTable/StatusColumn.js"),l=t("./app/containers/OrdersTable/AddressColumn.js"),d=t("./app/containers/OrdersTable/OrdersFooter.js"),u=t("./node_modules/moment/src/moment.js"),c=t("./node_modules/lodash/find.js"),p=t.n(c),f=t("./node_modules/lodash/filter.js"),m=t.n(f),h=t("./node_modules/react/react.js"),y=t.n(h),b=t("./app/components/Money/index.js"),v=Object.assign||function(e){for(var n=1;n<arguments.length;n++){var t=arguments[n];for(var r in t)Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r])}return e},g=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),j=g("small",{},void 0,"–"),_=function(e){var n=e.rowKey,c=e.loading,f=e.pagination,h=e.dataSource,_=e.shipOrder,x=(r(e,["rowKey","loading","pagination","dataSource","shipOrder"]),{rowKey:n,loading:c,pagination:f,dataSource:h});return y.a.createElement(o.a.Wrapper,v({footer:function(e){return g(d.a,{orders:e})}},x),g(o.a.Column,{width:85,title:"Status",dataIndex:"status",render:function(e,n){return"paid"==e?g(a.a,{status:e,orderID:n.id,shipOrder:_}):g(i.a,{status:e})}},"status"),g(o.a.Column,{width:125,title:"Date Ordered",dataIndex:"created",className:"data-col",render:function(e){return t.i(u.a)(e,"X").format("MMM Do, YYYY")}},"order_date"),g(o.a.Column,{width:125,title:"Date Shipped",dataIndex:"status_transitions",className:"data-col",render:function(e){return e.fulfiled?t.i(u.a)(e.fulfiled,"X").format("MMM Do, YYYY"):j}},"shipped_date"),g(o.a.Column,{title:"Customer",dataIndex:"shipping",className:"data-col",render:function(e){return g("strong",{},void 0,e.name)}},"customer"),g(o.a.Column,{title:"Address",dataIndex:"shipping",render:function(e){return g(l.a,{address:e.address})}},"address"),g(o.a.Column,{title:"Order",dataIndex:"items",render:function(e){return g(s.a,{items:m()(e,{type:"sku"})})}},"order"),g(o.a.Column,{width:70,title:"Tax",dataIndex:"items",render:function(e){return g(b.a,{value:p()(e,{type:"tax"}).amount/100})}},"sales_tax"),g(o.a.Column,{width:70,title:"Shipping",dataIndex:"items",render:function(e){return g(b.a,{value:p()(e,{type:"shipping"}).amount/100})}},"shipping"),g(o.a.Column,{width:85,title:"Total",dataIndex:"amount",render:function(e){return g(b.a,{value:e/100})}},"total"))};_.defaultProps={rowKey:"id",loading:!1,dataSource:[],pagination:!1},n.a=_},"./app/containers/OrdersTable/ShipColumn.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./node_modules/antd/lib/switch/style/css.js"),a=(t.n(o),t("./node_modules/antd/lib/switch/index.js")),s=t.n(a),i=t("./node_modules/antd/lib/popconfirm/style/css.js"),l=(t.n(i),t("./node_modules/antd/lib/popconfirm/index.js")),d=t.n(l),u=t("./node_modules/react/react.js"),c=(t.n(u),function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}()),p=c("br",{}),f=c("small",{},void 0,"mark shipped"),m=function(e){var n=e.status,t=e.orderID,o=e.shipOrder;r(e,["status","orderID","shipOrder"]);return c(d.a,{okText:"Yes",cancelText:"No",placement:"right",title:"Mark this order as shipped?",onConfirm:function(){return o(t,"fulfilled")}},void 0,c("a",{},void 0,c(s.a,{size:"small",checked:"fulfilled"==n}),p,f))};n.a=m},"./app/containers/OrdersTable/StatusColumn.js":function(e,n,t){"use strict";function r(e,n){var t={};for(var r in e)n.indexOf(r)>=0||Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r]);return t}var o=t("./node_modules/antd/lib/icon/style/css.js"),a=(t.n(o),t("./node_modules/antd/lib/icon/index.js")),s=t.n(a),i=t("./node_modules/react/react.js"),l=(t.n(i),t("./app/utils/orders.js")),d=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),u=d("br",{}),c=function(e){var n=e.status;r(e,["status"]);return d("div",{},void 0,d(s.a,{type:t.i(l.c)(n,!1),style:{color:t.i(l.b)(n),fontSize:"1.5em"}}),u,d("small",{style:{color:t.i(l.b)(n)}},void 0,t.i(l.d)(n)))};n.a=c},"./app/containers/OrdersTable/index.js":function(e,n,t){"use strict";var r=t("./node_modules/react-redux/lib/index.js"),o=(t.n(r),t("./app/containers/OrdersTable/OrdersTable.js")),a=t("./app/modules/orders/actions.js"),s=function(e){return{}},i=function(e){return{shipOrder:function(n,t){return e(a.a.ship(n,t))}}};n.a=t.i(r.connect)(s,i)(o.a)},"./app/containers/OrdersTable/styles.js":function(e,n,t){"use strict";function r(e,n){return Object.freeze(Object.defineProperties(e,{raw:{value:Object.freeze(n)}}))}var o=t("./node_modules/antd/lib/table/style/css.js"),a=(t.n(o),t("./node_modules/antd/lib/table/index.js")),s=t.n(a),i=t("./node_modules/styled-components/dist/styled-components.es.js"),l=t("./app/styles/variables.js"),d=t("./app/styles/mixins.js"),u=r(["\n\n  table {\n    border-color : "," !important;\n    border-right : 1px solid ",";\n    table-layout : fixed;\n  }\n\n  th, td {\n    ","\n\n    border-color   : "," !important;\n    border-left    : 1px solid ",";\n    text-align     : center !important;\n  }\n\n  .ant-table-placeholder {\n    border-bottom : none;\n    border-left   : 1px solid ",";\n    border-right  : 1px solid ",";\n  }\n\n  .ant-table-footer {\n    border-radius : 0 0 4px 4px;\n    overflow      : hidden;\n    padding       : 0;\n  }\n"],["\n\n  table {\n    border-color : "," !important;\n    border-right : 1px solid ",";\n    table-layout : fixed;\n  }\n\n  th, td {\n    ","\n\n    border-color   : "," !important;\n    border-left    : 1px solid ",";\n    text-align     : center !important;\n  }\n\n  .ant-table-placeholder {\n    border-bottom : none;\n    border-left   : 1px solid ",";\n    border-right  : 1px solid ",";\n  }\n\n  .ant-table-footer {\n    border-radius : 0 0 4px 4px;\n    overflow      : hidden;\n    padding       : 0;\n  }\n"]),c=r([""],[""]),p=r(["\n  align-items     : center;\n  display         : flex;\n  justify-content : space-between;\n  padding         : 0.33em;\n  position        : relative;\n\n  span {\n    font-size   : 0.8rem;\n    line-height : 1;\n    position    : relative;\n\n    &:first-child {\n      padding-right : 0.67em;\n      text-align    : left;\n    }\n\n    &:last-child {\n      padding-left : 0.67em;\n      text-align   : right;\n    }\n  }\n\n  hr {\n    border     : none;\n    border-top : 1px dotted ",";\n    flex       : 1 0 auto;\n    height     : 0;\n  }\n"],["\n  align-items     : center;\n  display         : flex;\n  justify-content : space-between;\n  padding         : 0.33em;\n  position        : relative;\n\n  span {\n    font-size   : 0.8rem;\n    line-height : 1;\n    position    : relative;\n\n    &:first-child {\n      padding-right : 0.67em;\n      text-align    : left;\n    }\n\n    &:last-child {\n      padding-left : 0.67em;\n      text-align   : right;\n    }\n  }\n\n  hr {\n    border     : none;\n    border-top : 1px dotted ",";\n    flex       : 1 0 auto;\n    height     : 0;\n  }\n"]),f=r(["\n  border-color : "," !important;\n  border-right : 1px solid ",";\n  table-layout : fixed;\n\n  th {\n    background  : transparent !important;\n    font-weight : bold;\n  }\n\n  .member-col {\n    padding-bottom : 1em;\n    padding-top    : 1em;\n    vertical-align: top;\n  }\n\n  .ant-table-placeholder {\n    display: none;\n  }\n"],["\n  border-color : "," !important;\n  border-right : 1px solid ",";\n  table-layout : fixed;\n\n  th {\n    background  : transparent !important;\n    font-weight : bold;\n  }\n\n  .member-col {\n    padding-bottom : 1em;\n    padding-top    : 1em;\n    vertical-align: top;\n  }\n\n  .ant-table-placeholder {\n    display: none;\n  }\n"]),m=t.i(i.a)(s.a)(u,l.a.grayLightest,l.a.grayLightest,d.a.ellipsis(),l.a.grayLightest,l.a.grayLightest,l.a.grayLightest,l.a.grayLightest),h=t.i(i.a)(s.a.Column)(c),y=i.a.div(p,l.a.grayLighter),b=t.i(i.a)(s.a)(f,l.a.grayLightest,l.a.grayLightest);n.a={Wrapper:m,Column:h,Item:y,Footer:b}},"./app/routes/OrdersRoute/OrdersRoute.js":function(e,n,t){"use strict";function r(e,n){if(!(e instanceof n))throw new TypeError("Cannot call a class as a function")}function o(e,n){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!n||"object"!=typeof n&&"function"!=typeof n?e:n}function a(e,n){if("function"!=typeof n&&null!==n)throw new TypeError("Super expression must either be null or a function, not "+typeof n);e.prototype=Object.create(n&&n.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),n&&(Object.setPrototypeOf?Object.setPrototypeOf(e,n):e.__proto__=n)}var s=t("./node_modules/antd/lib/button/style/css.js"),i=(t.n(s),t("./node_modules/antd/lib/button/index.js")),l=t.n(i),d=t("./node_modules/antd/lib/badge/style/css.js"),u=(t.n(d),t("./node_modules/antd/lib/badge/index.js")),c=t.n(u),p=t("./app/routes/OrdersRoute/styles.js"),f=t("./node_modules/lodash/compact.js"),m=t.n(f),h=t("./node_modules/lodash/without.js"),y=t.n(h),b=t("./node_modules/lodash/flatMap.js"),v=t.n(b),g=t("./node_modules/lodash/includes.js"),j=t.n(g),_=t("./node_modules/react/react.js"),x=t.n(_),O=t("./app/containers/OrdersTable/index.js"),w=t("./app/components/BoundsWrapper/index.js"),S=t("./app/utils/orders.js"),C=function(){var e="function"==typeof Symbol&&Symbol.for&&Symbol.for("react.element")||60103;return function(n,t,r,o){var a=n&&n.defaultProps,s=arguments.length-3;if(t||0===s||(t={}),t&&a)for(var i in a)void 0===t[i]&&(t[i]=a[i]);else t||(t=a||{});if(1===s)t.children=o;else if(s>1){for(var l=Array(s),d=0;d<s;d++)l[d]=arguments[d+3];t.children=l}return{$$typeof:e,type:n,key:void 0===r?null:""+r,ref:null,props:t,_owner:null}}}(),P=function(){function e(e,n){for(var t=0;t<n.length;t++){var r=n[t];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}return function(n,t,r){return t&&e(n.prototype,t),r&&e(n,r),n}}(),I="Orders",k=C("h5",{},void 0,"Filter By Status:"),T=function(e){function n(){var e,t,a,s;r(this,n);for(var i=arguments.length,l=Array(i),d=0;d<i;d++)l[d]=arguments[d];return t=a=o(this,(e=n.__proto__||Object.getPrototypeOf(n)).call.apply(e,[this].concat(l))),a.state={filters:["fulfilled","paid"]},a.toggleFilter=function(e){var n=arguments.length>1&&void 0!==arguments[1]&&arguments[1],t=a.state.filters;t=n?y()(t,e):t.concat([e]),a.setState({filters:t})},s=t,o(a,s)}return a(n,e),P(n,[{key:"render",value:function(){var e=this,n=this.props.orders,r=n.data,o=(n.error,n.hasMore),a=n.isLoading,s=this.state.filters,i=m()(v()(r,function(e,n){return j()(s,n)?e:null}));return C(p.a.Page,{title:I,loading:a},void 0,C(w.a,{},void 0,C(p.a.Header,{},void 0,C("h3",{},void 0,v()(r,function(e){return e}).length," Orders"),C("div",{},void 0,k,S.a.map(function(n){var o=j()(s,n);return C(c.a,{showZero:!0,count:r[n]?r[n].length:0,style:{backgroundColor:t.i(S.b)(n)}},n,C(l.a,{type:o?"primary":"dashed",icon:t.i(S.c)(n,!o),onClick:function(){return e.toggleFilter(n,o)}},void 0,t.i(S.d)(n)))}))),C(O.a,{rowKey:"id",loading:a,dataSource:i,pagination:o})))}}]),n}(x.a.Component);n.a=T},"./app/routes/OrdersRoute/index.js":function(e,n,t){"use strict";Object.defineProperty(n,"__esModule",{value:!0});var r=t("./node_modules/react-redux/lib/index.js"),o=(t.n(r),t("./app/routes/OrdersRoute/OrdersRoute.js")),a=function(e){return{orders:e.orders}},s=function(e){return{}};n.default=t.i(r.connect)(a,s)(o.a)},"./app/routes/OrdersRoute/styles.js":function(e,n,t){"use strict";function r(e,n){return Object.freeze(Object.defineProperties(e,{raw:{value:Object.freeze(n)}}))}var o=t("./node_modules/styled-components/dist/styled-components.es.js"),a=t("./app/components/PageWrapper/index.js"),s=t("./app/styles/variables.js"),i=r([""],[""]),l=r(["\n  align-items     : center;\n  display         : flex;\n  justify-content : space-between;\n  margin-bottom   : ",";\n\n  > *:last-child {\n    align-items     : center;\n    display         : flex;\n    flex            : 1 1 auto;\n    justify-content : flex-end;\n\n    > * {\n      margin-left: 1em;\n    }\n  }\n"],["\n  align-items     : center;\n  display         : flex;\n  justify-content : space-between;\n  margin-bottom   : ",";\n\n  > *:last-child {\n    align-items     : center;\n    display         : flex;\n    flex            : 1 1 auto;\n    justify-content : flex-end;\n\n    > * {\n      margin-left: 1em;\n    }\n  }\n"]),d=t.i(o.a)(a.a)(i),u=o.a.header(l,s.a.gutter);n.a={Page:d,Header:u}},"./app/utils/orders.js":function(e,n,t){"use strict";function r(e){switch(e){case"fulfilled":return"Shipped";case"canceled":return"Canceled";case"created":return"Unpaid";case"paid":return"Needs to be Shipped";default:return""}}function o(e){switch(e){case"fulfilled":return s.a.green;case"canceled":return s.a.red;case"created":return s.a.yellow;case"paid":return s.a.blue;default:return s.a.gray}}function a(e){var n=!(arguments.length>1&&void 0!==arguments[1])||arguments[1];switch(e){case"fulfilled":return"check-circle"+(n?"-o":"");case"canceled":return"close-circle"+(n?"-o":"");case"created":return"exclamation-circle"+(n?"-o":"");case"paid":return"plus-circle"+(n?"-o":"");default:return""}}var s=t("./app/styles/variables.js");t.d(n,"a",function(){return i}),n.d=r,n.b=o,n.c=a;var i=["fulfilled","paid","created","canceled"]},"./node_modules/lodash/_arrayReduce.js":function(e,n){function t(e,n,t,r){var o=-1,a=null==e?0:e.length;for(r&&a&&(t=e[++o]);++o<a;)t=n(t,e[o],o,e);return t}e.exports=t},"./node_modules/lodash/_baseDifference.js":function(e,n,t){function r(e,n,t,r){var c=-1,p=a,f=!0,m=e.length,h=[],y=n.length;if(!m)return h;t&&(n=i(n,l(t))),r?(p=s,f=!1):n.length>=u&&(p=d,f=!1,n=new o(n));e:for(;++c<m;){var b=e[c],v=null==t?b:t(b);if(b=r||0!==b?b:0,f&&v===v){for(var g=y;g--;)if(n[g]===v)continue e;h.push(b)}else p(n,v,r)||h.push(b)}return h}var o=t("./node_modules/lodash/_SetCache.js"),a=t("./node_modules/lodash/_arrayIncludes.js"),s=t("./node_modules/lodash/_arrayIncludesWith.js"),i=t("./node_modules/lodash/_arrayMap.js"),l=t("./node_modules/lodash/_baseUnary.js"),d=t("./node_modules/lodash/_cacheHas.js"),u=200;e.exports=r},"./node_modules/lodash/_baseReduce.js":function(e,n){function t(e,n,t,r,o){return o(e,function(e,o,a){t=r?(r=!1,e):n(t,e,o,a)}),t}e.exports=t},"./node_modules/lodash/_createFind.js":function(e,n,t){function r(e){return function(n,t,r){var i=Object(n);if(!a(n)){var l=o(t,3);n=s(n),t=function(e){return l(i[e],e,i)}}var d=e(n,t,r);return d>-1?i[l?n[d]:d]:void 0}}var o=t("./node_modules/lodash/_baseIteratee.js"),a=t("./node_modules/lodash/isArrayLike.js"),s=t("./node_modules/lodash/keys.js");e.exports=r},"./node_modules/lodash/compact.js":function(e,n){function t(e){for(var n=-1,t=null==e?0:e.length,r=0,o=[];++n<t;){var a=e[n];a&&(o[r++]=a)}return o}e.exports=t},"./node_modules/lodash/find.js":function(e,n,t){var r=t("./node_modules/lodash/_createFind.js"),o=t("./node_modules/lodash/findIndex.js"),a=r(o);e.exports=a},"./node_modules/lodash/findIndex.js":function(e,n,t){function r(e,n,t){var r=null==e?0:e.length;if(!r)return-1;var l=null==t?0:s(t);return l<0&&(l=i(r+l,0)),o(e,a(n,3),l)}var o=t("./node_modules/lodash/_baseFindIndex.js"),a=t("./node_modules/lodash/_baseIteratee.js"),s=t("./node_modules/lodash/toInteger.js"),i=Math.max;e.exports=r},"./node_modules/lodash/isArrayLikeObject.js":function(e,n,t){function r(e){return a(e)&&o(e)}var o=t("./node_modules/lodash/isArrayLike.js"),a=t("./node_modules/lodash/isObjectLike.js");e.exports=r},"./node_modules/lodash/reduce.js":function(e,n,t){function r(e,n,t){var r=l(e)?o:i,d=arguments.length<3;return r(e,s(n,4),t,d,a)}var o=t("./node_modules/lodash/_arrayReduce.js"),a=t("./node_modules/lodash/_baseEach.js"),s=t("./node_modules/lodash/_baseIteratee.js"),i=t("./node_modules/lodash/_baseReduce.js"),l=t("./node_modules/lodash/isArray.js");e.exports=r},"./node_modules/lodash/without.js":function(e,n,t){var r=t("./node_modules/lodash/_baseDifference.js"),o=t("./node_modules/lodash/_baseRest.js"),a=t("./node_modules/lodash/isArrayLikeObject.js"),s=o(function(e,n){return a(e)?r(e,n):[]});e.exports=s}});