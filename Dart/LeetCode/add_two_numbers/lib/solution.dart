import 'package:add_two_numbers/list_node.dart';

class Solution {
  ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
    var l1Curr = l1;
    var l2Curr = l2;
    ListNode? resListHead;
    ListNode? resListCurr;

    var nextOrder = 0;
    while (l1Curr != null || l2Curr != null) {
      final v1 = getZeroOrValue(l1Curr);
      final v2 = getZeroOrValue(l2Curr);

      final value = v1 + v2 + nextOrder;
      final currentOrder = value % 10;
      nextOrder = value ~/ 10;

      if (resListCurr == null) {
        resListHead = ListNode(currentOrder, null);
        resListCurr = resListHead;
      } else {
        resListCurr.next = ListNode(currentOrder, null);
        resListCurr = resListCurr.next;
      }

      if (l1Curr != null) l1Curr = l1Curr.next;
      if (l2Curr != null) l2Curr = l2Curr.next;
    }

    if (nextOrder != 0) {
      resListCurr!.next = ListNode(nextOrder, null);
      resListCurr = resListCurr.next;
    }

    return resListHead;
  }

  int getZeroOrValue(ListNode? currentNode1) {
    if (currentNode1 == null) {
      return 0;
    } else {
      return currentNode1.val;
    }
  }
}

