import 'package:add_two_numbers/list_node.dart';
import 'package:add_two_numbers/solution.dart';
import 'package:test/test.dart';

void main() {
  test('Example 1', () {
    expect(Solution().addTwoNumbers([2,4,3].toListNode(), [5,6,4].toListNode())?.toList(), [7,0,8]);
  });

  test('Example 2', () {
    expect(Solution().addTwoNumbers([0].toListNode(), [0].toListNode())?.toList(), [0]);
  });

  test('Example 3', () {
    expect(Solution().addTwoNumbers([9,9,9,9,9,9,9].toListNode(), [9,9,9,9].toListNode())?.toList(), [8,9,9,9,0,0,0,1]);
  });
}

extension ConverterToListNode on List {
  ListNode? toListNode() {
    ListNode? listHead;
    ListNode? currNode;
    for(var item in this) {
      if (currNode == null) {
        listHead = ListNode(item, null);
        currNode = listHead;
      } else {
        currNode.next = ListNode(item, null);
        currNode = currNode.next;
      }
    }

    return listHead;
  }
}

extension ConverterToList on ListNode {
  List<int> toList() {
    ListNode? current = this;
    var result = <int>[];

    while(current != null) {
      result.add(current.val);
      current = current!.next;
    }

    return result;
  }
}